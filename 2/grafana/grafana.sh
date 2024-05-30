#!/bin/bash

# Install dependencies
sudo apt-get install -y apt-transport-https software-properties-common wget

# Add Grafana GPG key and repository
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Update and install Grafana
sudo apt-get update
sudo apt-get install grafana

# Enable and start Grafana service
sudo systemctl enable --now grafana-server.service
sudo systemctl status grafana-server.service
