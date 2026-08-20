#!/usr/bin/env bash

# Linux Server Security Audit
#
# Read-only audit script.
# This script does not modify system configuration.

set -uo pipefail

echo "======================================"
echo " Linux Server Security Audit"
echo "======================================"
echo

echo "[ System Information ]"
echo "Hostname: $(hostname)"
echo "Kernel:   $(uname -r)"
echo "Uptime:   $(uptime -p 2>/dev/null || true)"
echo

echo "[ SSH Configuration ]"

if command -v sshd >/dev/null 2>&1; then
    sshd -T 2>/dev/null | grep -E \
        '^(permitrootlogin|pubkeyauthentication|passwordauthentication|maxauthtries|logingracetime) '
else
    echo "WARNING: sshd command not found"
fi

echo

echo "[ Firewall ]"

if command -v ufw >/dev/null 2>&1; then
    sudo ufw status verbose
else
    echo "WARNING: UFW is not installed"
fi

echo

echo "[ Fail2Ban ]"

if command -v fail2ban-client >/dev/null 2>&1; then
    sudo fail2ban-client status
else
    echo "WARNING: Fail2Ban is not installed"
fi

echo

echo "[ Disk Usage ]"
df -h /

echo

echo "[ Memory ]"
free -h

echo

echo "[ Listening Services ]"

if command -v ss >/dev/null 2>&1; then
    ss -tuln
else
    echo "WARNING: ss command not found"
fi

echo

echo "[ Active Security Services ]"

for service in ssh fail2ban; do
    if systemctl is-active --quiet "$service" 2>/dev/null; then
        echo "[OK] $service is active"
    else
        echo "[WARNING] $service is not active"
    fi
done

echo

echo "[ Firewall Status ]"

if command -v ufw >/dev/null 2>&1; then
    if sudo ufw status | grep -q "Status: active"; then
        echo "[OK] UFW is active"
    else
        echo "[WARNING] UFW is not active"
    fi
else
    echo "[WARNING] UFW is not installed"
fi

echo

echo "======================================"
echo " Audit completed"
echo "======================================"