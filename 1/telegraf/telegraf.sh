#!/bin/bash

# Download the telegraf package
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.19.1_linux_amd64.tar.gz

# Extract the telegraf package
tar xvzf telegraf-1.19.1_linux_amd64.tar.gz

# Change to the extracted directory
cd telegraf-1.19.1_linux_amd64/usr/bin

# Generate the telegraf configuration file
./telegraf config > telegraf.conf

# Move the configuration file to /etc/telegraf/
sudo mv telegraf.conf /etc/telegraf/

# Open the configuration file with vi editor to search for "outputs.influxdb"
sudo vi /etc/telegraf/telegraf.conf
