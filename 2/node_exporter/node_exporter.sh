#!/bin/bash

# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz

# Extract the archive
tar xvf node_exporter-1.8.0.linux-amd64.tar.gz

# Move binary to /usr/local/bin
cd node_exporter-1.8.0.linux-amd64
sudo mv node_exporter /usr/local/bin/

# Create systemd service file for Node Exporter
sudo bash -c 'cat > /etc/systemd/system/node-exporter.service' <<EOL
[Unit]
Description=Node Exporter

[Service]
Restart=always
User=prometheus
ExecStart=/usr/local/bin/node_exporter
ExecReload=/bin/kill -HUP \$MAINPID
TimeoutStopSec=20s
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, enable and start Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable --now node-exporter.service
sudo systemctl status node-exporter.service
