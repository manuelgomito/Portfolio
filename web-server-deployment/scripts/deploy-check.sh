#!/usr/bin/env bash

# Web Server Deployment Validation
#
# Read-only validation script.
# This script checks the expected infrastructure components
# without modifying system configuration.

set -uo pipefail

echo "======================================"
echo " Web Server Deployment Check"
echo "======================================"
echo

check_command() {
    local command_name="$1"

    if command -v "$command_name" >/dev/null 2>&1; then
        echo "[OK] Command available: $command_name"
    else
        echo "[WARNING] Command not found: $command_name"
    fi
}

check_service() {
    local service_name="$1"

    if systemctl is-active --quiet "$service_name" 2>/dev/null; then
        echo "[OK] Service active: $service_name"
    else
        echo "[WARNING] Service not active: $service_name"
    fi
}

echo "[ Required Commands ]"

check_command nginx
check_command php
check_command mysql
check_command redis-cli
check_command ss

echo
echo "[ Service Status ]"

check_service nginx
check_service mariadb
check_service redis-server

echo
echo "[ Nginx Configuration ]"

if command -v nginx >/dev/null 2>&1; then
    if nginx -t 2>/dev/null; then
        echo "[OK] Nginx configuration is valid"
    else
        echo "[WARNING] Nginx configuration validation failed"
    fi
else
    echo "[WARNING] Nginx is not installed"
fi

echo
echo "[ Network Ports ]"

if command -v ss >/dev/null 2>&1; then
    ss -tuln | grep -E ':(22|80|443)\b' || \
        echo "[INFO] Expected web/SSH ports are not currently listening"
else
    echo "[WARNING] ss command not found"
fi

echo
echo "[ Disk Usage ]"

df -h /

echo
echo "[ Memory Usage ]"

free -h

echo
echo "[ Listening Services ]"

if command -v ss >/dev/null 2>&1; then
    ss -tuln
fi

echo
echo "======================================"
echo " Deployment check completed"
echo "======================================"
