FROM debian:bookworm-slim

# Install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    corosync-qnetd \
    openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Create SSH directory and set up SSH
RUN mkdir -p /var/run/sshd && \
    sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# the root password from ENV at container start
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose SSH and corosync-qnetd ports
EXPOSE 22 5403

# Start script sets root password and starts SSH
CMD ["/usr/local/bin/entrypoint.sh"]