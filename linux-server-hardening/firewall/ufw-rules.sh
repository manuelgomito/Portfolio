#!/usr/bin/env bash

# UFW firewall baseline for an Ubuntu web server.

#

# IMPORTANT:

# Review the rules before applying them to production.

# Make sure SSH access is available before enabling UFW.

set -euo pipefail

echo "Configuring UFW firewall..."

# Default policies

sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH

sudo ufw allow OpenSSH

# HTTP

sudo ufw allow 80/tcp

# HTTPS

sudo ufw allow 443/tcp

# Enable firewall

sudo ufw --force enable

# Display current status

sudo ufw status verbose
