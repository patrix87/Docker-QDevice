# Docker-QDevice

This repository contains a Docker container for running `corosync-qdevice` and `corosync-qnetd`, which are required for high-availability (HA) clustering. The container is designed to work with Proxmox and allows configuration of the quorum device (`qdevice`) via SSH using the root account.

---

## **Features**

- Runs `corosync-qdevice` and `corosync-qnetd` for HA clustering.
- Includes an SSH server for remote configuration by Proxmox.
- Allows root login with a password for compatibility with Proxmox's configuration requirements.

---

## **Security Notice**

This container is **not secure for use on public networks**. It is intended to be deployed **only in a secure local network with no internet access**. The following security risks are present:

- Port 22 (SSH) is exposed.
- Root login is permitted with a password.

These configurations are necessary for Proxmox to configure the quorum device (`qdevice`).

---

## **Usage**

### **1. Prerequisites**

- Ensure Docker and Docker Compose are installed on your system.
- Deploy this container in a secure, isolated network environment.

---

### **2. Environment Variables**

The container requires the following environment variable to be set:

- `ROOT_PASSWORD`: The root password for SSH access.

You can set this in the `.env` file:

```dotenv
ROOT_PASSWORD=your_secure_password
```

In addition to `ROOT_PASSWORD`, the following environment variable can be set:

- `ALLOWED_SSH_IPS`: A comma-separated list of IPs or IP ranges allowed to connect via SSH. Example:

```dotenv
ALLOWED_SSH_IPS=192.168.1.100,192.168.1.0/24
```

### **Notes on `ALLOWED_SSH_IPS`**

- If `ALLOWED_SSH_IPS` is not set or is empty, the container will allow SSH connections from all IPs.
- When running the container locally on Docker Desktop, the container might see a different IP for the host machine due to Docker's internal networking. To troubleshoot:
  - Check the container's logs for incoming connection attempts.
  - Use `docker inspect <container_name>` to identify the container's network configuration.
  - Adjust `ALLOWED_SSH_IPS` accordingly.

---

## **Logging**

The container logs the following events to `/var/log/container.log`:

- When the container starts.
- When the root password is changed.
- When SSH access is restricted to specific IPs.

---

## **Healthcheck**

The container includes a healthcheck to ensure that `corosync` is running. Docker will monitor the container's health and restart it if necessary.
