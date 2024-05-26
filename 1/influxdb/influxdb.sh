#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update the package list and upgrade all packages
sudo apt update && sudo apt upgrade -y

# Download Telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.19.1_linux_amd64.tar.gz

# Extract the downloaded tarball
tar xvzf telegraf-1.19.1_linux_amd64.tar.gz

# Move to the directory containing Telegraf binaries
cd telegraf-1.19.1/usr/bin

# Generate a default Telegraf configuration file
./telegraf config > telegraf.conf

# Move the configuration file to the appropriate directory
sudo mv telegraf.conf /etc/telegraf/

# Edit the Telegraf configuration file
sudo vi /etc/telegraf/telegraf.conf

# Installation complete
