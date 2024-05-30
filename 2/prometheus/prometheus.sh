#!/bin/bash

# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz

# Extract the archive
tar xvf prometheus-2.52.0.linux-amd64.tar.gz

# Change to the extracted directory
cd prometheus-2.52.0.linux-amd64

# Create Prometheus user and group
sudo groupadd --system prometheus
sudo useradd --system -s /sbin/nologin -g prometheus prometheus

# Move binaries to /usr/local/bin
sudo mv prometheus promtool /usr/local/bin/

# Create directories and set permissions
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus/
sudo mv consoles/ console_libraries/ prometheus.yml /etc/prometheus/

# Create systemd service file for Prometheus
sudo bash -c 'cat > /etc/systemd/system/prometheus.service' <<EOL
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, enable and start Prometheus
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus
sudo systemctl status prometheus
