#!/bin/bash

# Update package list and upgrade all installed packages to the latest versions
echo "Updating and upgrading packages..."
sudo apt update && sudo apt upgrade -y

# Install the default Java Runtime Environment (JRE)
echo "Installing default JRE..."
sudo apt install default-jre -y

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Download OpenJDK 8 JRE Headless package
echo "Downloading OpenJDK 8 JRE Headless package..."
curl -qo /tmp/openjdk-8-jre-headless_8u275-b01.deb "https://launchpadlibrarian.net/505954411/openjdk-8-jre-headless_8u275-b01-0ubuntu1~18.04_amd64.deb"

# Install OpenJDK 8 JRE Headless package
echo "Installing OpenJDK 8 JRE Headless package..."
sudo dpkg -i /tmp/openjdk-8-jre-headless_8u275-b01.deb

# Hold the OpenJDK 8 JRE Headless package to prevent automatic upgrades
echo "Holding OpenJDK 8 JRE Headless package..."
sudo apt-mark hold openjdk-8-jre-headless

# Download OpenSSL package
echo "Downloading OpenSSL package..."
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Install OpenSSL package
echo "Installing OpenSSL package..."
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Add keyring for MongoDB
echo "Adding MongoDB keyring..."
curl https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg >/dev/null

# Add MongoDB repository
echo "Adding MongoDB repository..."
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null

# Update package list after adding MongoDB repository
echo "Updating package list after adding MongoDB repository..."
sudo apt update -y

# Install MongoDB server
echo "Installing MongoDB server..."
sudo apt install mongodb-org-server -y

# Add keyring for UniFi
echo "Adding UniFi keyring..."
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null

# Add UniFi repository
echo "Adding UniFi repository..."
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list > /dev/null

# Update package list after adding UniFi repository
echo "Updating package list after adding UniFi repository..."
sudo apt update -y

# Install UniFi
echo "Installing UniFi..."
sudo apt install unifi -y

# Check UniFi service status
echo "Checking UniFi service status..."
systemctl status unifi

# Install net-tools
echo "Installing net-tools..."
sudo apt install net-tools -y

# Check open ports
echo "Checking open ports..."
netstat -tnl

echo "Installation and setup completed."
