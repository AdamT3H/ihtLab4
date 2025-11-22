#!/bin/bash

# === Update system ===
apt update -y

# === Create adminuser ===
adduser --disabled-password --gecos "" adminuser

# Set secure password for adminuser
# (change "AdminPass123!" to anything you want – chpasswd will hash it)
echo "adminuser:AdminPass123!" | chpasswd

# Add adminuser to sudo group
usermod -aG sudo adminuser

# === Create poweruser ===
adduser --disabled-password --gecos "" poweruser

# Allow poweruser login WITHOUT password
# Empty password field in /etc/passwd
sed -i 's/^poweruser:[^:]*:/poweruser::/' /etc/passwd

# === Allow poweruser to run ONLY iptables with sudo (no password) ===
IPT=$(which iptables)
echo "poweruser ALL=(root) NOPASSWD: $IPT" >> /etc/sudoers

# === Allow poweruser to READ /home/adminuser ===
groupadd adminaccess
usermod -aG adminaccess poweruser
chown adminuser:adminaccess /home/adminuser
chmod 750 /home/adminuser   # drwxr-x---

# === Create symlink in poweruser home directory ===
sudo -u poweruser ln -s /etc/mtab /home/poweruser/mtab_link

echo "===== ALL DONE SUCCESSFULLY ====="
