#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install necessary packages
sudo apt install -y python3 python3-full npm git

# Install pm2 globally
sudo npm install -g pm2

# Install Python packages
pip3 install discord.py PyNaCl aiosqlite --break-system-packages

# Set up pm2 to start on boot
pm2 startup -s

# Configure Git
git config --global user.email "mtmralone@gmail.com"
git config --global user.name "MTMrAlone"

# Create a directory for the servers
mkdir -p /root/Server
cd /root/Server

# Define an array of repositories and their corresponding process names
declare -A repos=(
  ["Terminal-Bot"]="terminal"
)

# Clone repositories and start pm2 processes
for repo in "${!repos[@]}"; do
  git clone "git@github.com:MTMrAlone/$repo.git"
  cd "/root/server/$repo"
  pm2 start start.sh --name "${repos[$repo]}" -s
  echo $repo Successfully setupped.
  cd /root/Server
done

# Save pm2 process list
pm2 save -s

# Display all added repositories
pm2 status
