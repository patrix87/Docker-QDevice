#!/bin/bash

# Log container start
echo "Container started."

if [ -z "$ROOT_PASSWORD" ]; then
  echo "ROOT_PASSWORD environment variable is not set. Exiting."
  exit 1
fi

echo "root:$ROOT_PASSWORD" | chpasswd
echo "Root password changed."

# Log incoming SSH connections
echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config
echo "SyslogFacility AUTH" >> /etc/ssh/sshd_config
echo "Logging enabled for incoming SSH connections."

# Start the SSH server
exec /usr/sbin/sshd -D -e
