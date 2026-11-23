#!/usr/bin/env bash
set -euo pipefail
[[ $EUID -eq 0 ]] || { echo "kør som root"; exit 1; }
apt-get update && apt-get -y full-upgrade
xargs -a packages.list apt-get -y install
systemctl enable --now fail2ban unattended-upgrades chrony
timedatectl set-timezone Europe/Copenhagen
sed -i "s/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/" /etc/ssh/sshd_config
systemctl reload ssh
echo "Færdig."
