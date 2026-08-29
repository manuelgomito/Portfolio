# Backup System Architecture

This document describes the logical architecture of the weekly backup system and the relationship between its main components.

The architecture separates the backup workflow from the underlying infrastructure. The backup process can therefore be adapted to different environments without changing its fundamental design.

## 1. Architecture Overview

The backup system is composed of four primary elements:

- Source Server
- Backup Server
- Persistent Backup Storage
- Backup Monitoring

The source server contains the production data. The backup server receives and manages the backup data, while persistent storage maintains the data independently from the operating system of the backup server.

The Watchdog provides monitoring of the backup operation and helps identify abnormal conditions.

## 2. Logical Architecture

The main data path is:

Source Server
  │
  │ SSH + rsync
  ▼
Backup Server
  │
  ▼
Persistent Backup Storage
  │
  ▼
Recovery

The backup server acts as the controlled destination for backup operations.

## 3. Source Server

The source server is the system whose data is being protected.

It may contain:

- Application data
- Configuration files
- Website data
- Database data
- System-related data required for recovery

The source server initiates the backup workflow according to the configured schedule.

The backup process does not require the source server to expose backup storage directly to the network.

## 4. Backup Server

The backup server is a dedicated system responsible for receiving and maintaining backup data.

Its main responsibilities are:

- Receiving backup data
- Providing the backup destination
- Maintaining backup operations
- Providing access to persistent backup storage
- Supporting recovery operations
- Participating in backup monitoring

The backup server should remain dedicated to backup operations and should not be treated as a general-purpose application server.

## 5. Persistent Backup Storage

Backup data is stored on persistent storage mounted on the backup server.

The storage is logically represented as:

/backup

Persistent storage separates the backup data from the operating system of the backup server.

This provides an additional layer of protection against situations where the backup server operating system must be restarted, replaced, or recreated.

The storage capacity should be monitored to prevent backup failures caused by insufficient disk space.

## 6. Secure Data Transfer

Communication between the source server and backup server uses SSH.

Data synchronization is performed using `rsync` over the SSH connection.

The model is:

Source Server
  │
  │ SSH
  │
  └── rsync
       │
       ▼
Backup Server

SSH provides the secure transport layer, while `rsync` performs the synchronization of backup data.

## 7. Backup Workflow Layer

The backup workflow sits between scheduling and the actual data transfer.

Its responsibility is to control the sequence of operations.

The logical relationship is:

Cron
  │
  ▼
Backup Script
  │
  ├── Execution Lock
  │
  ├── Connectivity Check
  │
  ├── Data Synchronization
  │
  ├── Backup Validation
  │
  └── Final Status

The workflow is responsible for determining whether the backup operation completed successfully.

Detailed execution logic is documented in [`backup-workflow.md`](backup-workflow.md).

## 8. Watchdog Monitoring

The Watchdog represents the monitoring function of the backup system.

It observes the operational state of the backup process and helps identify abnormal conditions.

The Watchdog can monitor:

- Backup execution
- Backup completion
- Failed operations
- Connectivity problems
- Storage availability
- Execution errors
- Unexpected backup states

The Watchdog does not replace the backup process.

Its purpose is to provide an additional layer of operational visibility.

The relationship is:

Backup Workflow
      │
      ▼
Watchdog
      │
      ▼
Detection of abnormal conditions
      │
      ▼
Notification / Administrative Action

## 9. Logging and State

The backup system maintains operational information about its executions.

Logs provide historical information about backup activity, while state information represents the current or most recent execution condition.

The logical relationship is:

Backup Workflow
      │
      ├── Logs
      │
      └── Backup State

This information supports monitoring, troubleshooting, and recovery verification.

## 10. Notification

When the backup operation finishes, its final state can be communicated through email notification.

The notification layer provides administrative visibility into the result of the backup.

The general relationship is:

Backup Workflow
      │
      ▼
Final Status
      │
      ▼
Email Notification

Notifications should clearly indicate whether the backup was:

- Successful
- Partial or completed with warnings
- Failed

## 11. Recovery Architecture

Recovery uses the backup server and persistent storage as the source of the protected data.

The recovery path is:

Persistent Backup Storage
        │
        ▼
Backup Data
        │
        ▼
Restore Operation
        │
        ▼
Source Server or Recovery Environment

The recovery process must not depend exclusively on the availability of the original source server.

If the original server becomes unavailable, the stored backup data should remain accessible for restoration to another suitable environment.

Detailed recovery procedures are documented in [`recovery.md`](recovery.md).

## 12. Security Boundaries

The architecture separates the production environment from the backup environment.

The main security boundary is the SSH connection between the source server and backup server.

The backup server should restrict access to trusted systems and administrators.

The backup storage should not be directly exposed as a public service.

The architecture therefore follows this model:

Source Server
  │
  │ Restricted SSH Access
  ▼
Backup Server
  │
  ▼
Private Backup Storage

Sensitive infrastructure-specific information is intentionally excluded from the public documentation.

## 13. Architecture Principles

The architecture follows these principles:

- Separation — backup infrastructure is separated from the source server.
- Persistence — backup data is stored independently from the backup server operating system.
- Security — data transfer uses authenticated SSH connections.
- Automation — backup execution is initiated by a predictable schedule.
- Monitoring — backup operations are observed by the Watchdog.
- Validation — completed backups are evaluated before being reported as successful.
- Recoverability — the architecture is designed around restoration, not only data transfer.
- Portability — the logical backup architecture is not dependent on a specific infrastructure provider.

## 14. Overall System Model

The complete architecture can be summarized as:

Weekly Schedule
      │
      ▼
Backup Workflow
      │
      ▼
Source Server
      │
      │ SSH + rsync
      ▼
Backup Server
      │
      ▼
Persistent Backup Storage
      │
      ├──────────────► Watchdog Monitoring
      │
      ├──────────────► State and Logs
      │
      └──────────────► Recovery

The infrastructure provider is an implementation detail.

The fundamental architecture remains based on secure synchronization, persistent storage, controlled execution, monitoring, validation, and recoverability.
