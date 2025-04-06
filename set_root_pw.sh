#!/bin/bash

# Log container start
echo "Container started."

if [ -z "$ROOT_PASSWORD" ]; then
  echo "ROOT_PASSWORD environment variable is not set. Exiting."
  exit 1
fi

echo "root:$ROOT_PASSWORD" | chpasswd
echo "Root password changed."

# Start the SSH server
exec /usr/sbin/sshd -D -e
