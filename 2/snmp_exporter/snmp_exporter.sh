#!/bin/bash

# Download SNMP Exporter
wget https://github.com/prometheus/snmp_exporter/releases/download/v0.26.0/snmp_exporter-0.26.0.linux-amd64.tar.gz

# Extract the archive
tar xvf snmp_exporter-0.26.0.linux-amd64.tar.gz

# Move binary to /usr/local/bin
cd snmp_exporter-0.26.0.linux-amd64
sudo mv snmp_exporter /usr/local/bin/

# Create SNMP configuration directory and move config file
sudo mkdir /etc/snmp_exporter
sudo mv snmp.yml /etc/snmp_exporter/

# Create systemd service file for SNMP Exporter
sudo bash -c 'cat > /etc/systemd/system/snmp-exporter.service' <<EOL
[Unit]
Description=SNMP Exporter
After=network-online.target

[Service]
User=prometheus
Restart=on-failure
ExecStart=/usr/local/bin/snmp_exporter --config.file='/etc/snmp_exporter/snmp.yml'

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, enable and start SNMP Exporter
sudo systemctl daemon-reload
sudo systemctl enable --now snmp-exporter.service
sudo systemctl status snmp-exporter.service
