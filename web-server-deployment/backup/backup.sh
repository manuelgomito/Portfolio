#!/usr/bin/env bash

# Web Server Backup Script
#
# Example backup automation for a Linux web server.
# Review and adapt paths, database credentials and retention
# before using in a production environment.

set -euo pipefail

# Configuration
BACKUP_DIR="/var/backups/web-server"
WEB_ROOT="/var/www/example.com"
DATABASE_NAME="example_db"
DATABASE_USER="backup_user"
RETENTION_DAYS=7

TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
BACKUP_PATH="${BACKUP_DIR}/${TIMESTAMP}"

echo "======================================"
echo " Web Server Backup"
echo "======================================"
echo

echo "[INFO] Creating backup directory..."
mkdir -p "$BACKUP_PATH"

echo "[INFO] Backing up web application files..."

tar -czf "${BACKUP_PATH}/website.tar.gz" \
    -C "$(dirname "$WEB_ROOT")" \
    "$(basename "$WEB_ROOT")"

echo "[INFO] Backing up MariaDB database..."

mysqldump \
    --single-transaction \
    --routines \
    --triggers \
    "$DATABASE_NAME" \
    > "${BACKUP_PATH}/database.sql"

gzip "${BACKUP_PATH}/database.sql"

echo "[INFO] Creating backup metadata..."

cat > "${BACKUP_PATH}/metadata.txt" <<META
Backup date: $(date --iso-8601=seconds)
Hostname: $(hostname)
Web root: ${WEB_ROOT}
Database: ${DATABASE_NAME}
META

echo "[INFO] Removing backups older than ${RETENTION_DAYS} days..."

find "$BACKUP_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -mtime +"$RETENTION_DAYS" \
    -exec rm -rf {} +

echo
echo "[OK] Backup completed successfully."
echo "[INFO] Backup location: ${BACKUP_PATH}"
