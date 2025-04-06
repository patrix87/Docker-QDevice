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

---
