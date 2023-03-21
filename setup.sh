#!/bin/bash
# -----------------------------------------------------------
# 1. Powerwash Chromebook: Ctrl + Alt + Shift + r
# 2. Check for ChromeOS updates: Clock > Settings > About ChromeOS
# 3. Launch crosh: Ctrl + Alt + t
# 4. Launch shell: shell
# 5. Download and run this script
# -----------------------------------------------------------

# read -p '[+] Checked for ChromeOS updates? ' updates
home='/home/chronos/user'
cd $home

# -----------------------------------------------------------
# Remount home directory without noexec
# -----------------------------------------------------------
sudo mount -o remount,rw -o exec $home

# -----------------------------------------------------------
# Install chromebrew and utilities
# -----------------------------------------------------------
curl -Ls git.io/vddgY | bash
crew update && \
  crew install git jq unzip

# -----------------------------------------------------------
# Install awscli
# -----------------------------------------------------------
curl -Ls "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$home/awscliv2.zip" && \
  unzip awscliv2.zip && \
  sudo $home/aws/install --update

cat << EOF >> $home/.bashrc
#
complete -C '/usr/local/bin/aws_completer' aws
EOF

echo "[+] Done! Please run: source $home/.bashrc"
