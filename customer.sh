#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Create a directory for the servers
mkdir -p /root/tmp
cd /root/tmp

# Define an array of repositories and their corresponding process names
declare -A repos=(
  ["MisaqDark-Bot"]="misaqdark"
  ["Bigezmoge-Bot"]="bigezmoge"
  ["CIA-Console"]="sagdas"
  ["Hexa-Bot"]="hexa"
  ["Getix-Bot"]="getix"
  ["XD-Bot"]="ehsanxd"
  ["Terminal-Bot"]="terminal"
  ["TLF-Bot"]="rose"
  ["Vettaz-Bot"]="vettaz"
  ["VoralCraft-Bot"]="voralcraft"
)

# Clone repositories and start pm2 processes
for repo in "${!repos[@]}"; do
  git clone "git@github.com:MahdiyarEmad/$repo.git" ${repos[$repo]}
  cd "/root/tmp/${repos[$repo]}"
  pm2 start start.sh --name "${repos[$repo]}" -s
  echo $repo Successfully setupped.
  cd /root/tmp
done

# Save pm2 process list
pm2 save -s

# Display all added repositories
pm2 status
