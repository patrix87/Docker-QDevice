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

### **2. Installation on Synology NAS**

- Install Container Manager on Synology NAS (It will create a shared folder named docker)
- Download this repository
- Copy the qdevice folder to your docker folder on the NAS
- Update the password in the .env to a very long and complex one.
- In Container Manager on the NAS
- - Select Project
- - Click Create
- - Name it qdevice
- - Set Path to the qdevice folder you created earlier
- - Select Use existing...
- - Click Next, Next, Done
- In PVE Shell join the QDevice to the Cluster
`pvecm qdevice setup <your-nas-ip> -f`
- say Yes and then type in the SSH password of the QDevice.
- Validate the status
`pvecm status`
- The QDevice should have a vote under Votes.
- You can validate if the corosync-qnetd is working in the docker with
`corosync-qnetd-tool -s`
- If you have issues check if your firewall rules allow UDP 5043 between the QDevice and the Cluster.

---

### **3. Environment Variables**

The container requires the following environment variable to be set:

- `ROOT_PASSWORD`: The root password for SSH access.

You can set this in the `.env` file:

```dotenv
ROOT_PASSWORD=your_secure_password
```

---

### **4. Credit and further documentation**

- <https://github.com/bcleonard/proxmox-qdevice>
- <https://github.com/modelrockettier/docker-corosync-qnetd>
- <https://manpages.debian.org/testing/corosync-qnetd/corosync-qnetd.8.en.html>
- <https://manpages.debian.org/testing/corosync-qnetd/corosync-qnetd-tool.8.en.html>
- <https://manpages.debian.org/testing/corosync-qnetd/corosync-qnetd-certutil.8.en.html>
- <https://pve.proxmox.com/wiki/Cluster_Manager>
- <https://documentation.suse.com/sle-ha/15-SP6/html/SLE-HA-all/cha-ha-qdevice.html>
- <https://raymii.org/s/tutorials/Proxmox_VE_7_Corosync_QDevice_in_Docker.html>
- <https://www.youtube.com/watch?v=TXFYTQKYlno>
- <https://www.youtube.com/watch?v=jAlzBm40onc>
- <https://www.youtube.com/watch?v=VqyqsKUawRI>
- <https://www.youtube.com/watch?v=IhEE_QlI1MU>