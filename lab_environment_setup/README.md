
# 🧰 Environment Setup for New Project: WSL + Docker/Podman + AWS CLI

This guide explains step-by-step how to set up a development environment on WSL (Windows Subsystem for Linux) to work with Docker, Podman, and AWS CLI.

## 📦 Manual Setup Steps

### 1. Install WSL (Windows Subsystem for Linux)
```bash
wsl --install
````

Installs WSL and the default Linux distribution.

### 2. Update the Linux system

```bash
sudo apt update && sudo apt upgrade -y
```

Updates the package index and upgrades installed packages.

### 3. Check sudo privileges

```bash
sudo whoami
```

Verifies you have administrative rights.

### 4. Install basic tools

```bash
sudo apt install -y curl wget git unzip nano build-essential
```

Installs essential tools for development and file management.

### 5. Install AWS CLI v2

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

Downloads, unzips, installs, and verifies AWS CLI.

### 6. Install Docker

```bash
sudo apt install docker.io -y
docker --version
```

Installs Docker and verifies the installation.

### 7. Install Podman and required tools

```bash
sudo apt install -y podman podman-docker uidmap fuse-overlayfs
```

Installs Podman and tools to emulate Docker functionality.

### 8. Enable Podman socket (acts like Docker daemon)

```bash
systemctl --user enable --now podman.socket
```

Enables Podman’s socket for container daemon emulation.

### 9. Verify Podman socket is active

```bash
curl --unix-socket $XDG_RUNTIME_DIR/podman/podman.sock http://d/v4.0.0/libpod/info
```

Checks Podman's socket status.

### 10. Alias docker to podman

```bash
echo 'alias docker=podman' >> ~/.bashrc
source ~/.bashrc
```

This allows you to use docker commands with Podman.

### 11. Verify everything works

```bash
docker --version
podman info
```

Verifies the alias and checks Podman configuration.

---

## ⚙️ Automated Setup Script

To avoid doing all steps manually, create a file named `setup_env.sh` and paste the following:

```bash
#!/bin/bash
set -e

echo "1. Updating system..."
sudo apt update && sudo apt upgrade -y

echo "2. Checking user..."
sudo whoami

echo "3. Installing basic tools..."
sudo apt install -y curl wget git unzip nano build-essential

echo "4. Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install
aws --version

echo "5. Installing Docker..."
sudo apt install -y docker.io
docker --version

echo "6. Installing Podman and required tools..."
sudo apt install -y podman podman-docker uidmap fuse-overlayfs

echo "7. Enabling Podman socket..."
systemctl --user enable --now podman.socket

echo "8. Verifying Podman socket..."
curl --unix-socket $XDG_RUNTIME_DIR/podman/podman.sock http://d/v4.0.0/libpod/info

echo "9. Creating alias docker=podman..."
grep -qxF "alias docker=podman" ~/.bashrc || echo 'alias docker=podman' >> ~/.bashrc
source ~/.bashrc

echo "10. Verifying alias and Podman..."
docker --version
podman info

echo "✅ Setup complete."
```

---

## ▶️ How to Run the Script

Save the script as `setup_env.sh` in your project folder.

Make it executable:

```bash
chmod +x setup_env.sh
```

Run it:

```bash
./setup_env.sh
```

---

## 📌 Notes

* This script assumes you have sudo access.
* Open a new terminal after the script to load the alias properly.
* On WSL2, if `systemd` is not enabled, `systemctl --user` may not work. Consider enabling `systemd` or managing the Podman socket manually.

```

---


