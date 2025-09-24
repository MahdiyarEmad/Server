#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install necessary packages
sudo apt install -y python3 python3-full npm git python3-pip python3-venv

# Install pm2 globally
sudo npm install -g pm2

# Install Python packages
pip install discord.py PyNaCl aiosqlite wavelink aiomysql pytz chat_exporter persiantools twitchAPI --break-system-packages

# Set up pm2 to start on boot
pm2 startup -s

# Configure Git
git config --global user.email "imahdiyaremad@gmail.com"
git config --global user.name "Mahdiyar Emad Server"

# Create a directory for the servers
mkdir -p /root/server
cd /root/server

# Define an array of repositories and their corresponding process names
declare -A repos=(
  ["FiveM-Timer"]="timer"
  ["Infinity"]="infinity"
  ["Soundify"]="soundify"
  ["Terminal-Bot"]="terminal"
)

# Clone repositories and start pm2 processes
for repo in "${!repos[@]}"; do
  git clone "git@github.com:MahdiyarEmad/$repo.git" ${repos[$repo]}
  cd "/root/server/${repos[$repo]}"
  pm2 start main.py --name "${repos[$repo]}" -s
  echo $repo Successfully setupped.
  cd /root/server
done

# Save pm2 process list
pm2 save -s

# Display all added repositories
pm2 status
