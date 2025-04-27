#!/bin/bash
set -e

# Log container start
echo "Container started."

KEYDIR=/root/ssh_host_keys
SSHD_ETC=/etc/ssh

if [ -z "$ROOT_PASSWORD" ]; then
  echo "ROOT_PASSWORD environment variable is not set. Exiting."
  exit 1
fi

# change root password
echo "root:$ROOT_PASSWORD" | chpasswd
echo "Root password changed."

# If mounted folder already has host keys, sync them into /etc/ssh
if compgen -G "${KEYDIR}/ssh_host_*key" > /dev/null; then
  echo "Found existing host keys in ${KEYDIR}, copying into ${SSHD_ETC}"
  cp "${KEYDIR}"/ssh_host_* "${SSHD_ETC}/"
else
  # First-run: populate KEYDIR from image’s /etc/ssh
  echo "No existing host keys; copying from ${SSHD_ETC} to ${KEYDIR}"
  cp "${SSHD_ETC}"/ssh_host_* "${KEYDIR}/"
fi

# Enforce permissions
chmod 600 "${KEYDIR}/ssh_host_"*key
chmod 644 "${KEYDIR}/ssh_host_"*.pub
chmod 600 "${SSHD_ETC}/ssh_host_"*key
chmod 644 "${SSHD_ETC}/ssh_host_"*.pub

# Start the SSH server
exec /usr/sbin/sshd -D -e
