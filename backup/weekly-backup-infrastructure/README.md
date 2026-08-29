# Weekly Backup Infrastructure

Automated weekly backup system designed to protect Linux server data through secure remote synchronization, persistent storage, monitoring, and recovery procedures.

The system separates the backup workflow from the underlying infrastructure, allowing the backup architecture to be adapted to different environments.

## Overview

The backup system consists of:

* Linux source server
* Dedicated remote backup server
* SSH key-based authentication
* `rsync` for data synchronization
* Bash-based backup orchestration
* `cron` for scheduled execution
* Persistent backup storage
* Backup state and operational logs
* Monitoring and failure detection
* Email notifications
* Recovery procedures

## Backup Architecture

```text
┌─────────────────────┐
│    Linux Server     │
│                     │
│ Application Data    │
│ Configuration       │
│ Database Data       │
└──────────┬──────────┘
           │
           │ SSH + rsync
           ▼
┌─────────────────────┐
│   Backup Server     │
│                     │
│ Backup Operations   │
│ Persistent Storage  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│    Backup Storage   │
│                     │
│       /backup       │
└─────────────────────┘
```

The current implementation uses AWS as the underlying infrastructure platform. The backup workflow itself remains largely independent of the infrastructure provider.

## Backup Workflow

The weekly backup follows a controlled execution process:

```text
Weekly Schedule
       │
       ▼
     Cron
       │
       ▼
Backup Script
       │
       ▼
Execution Lock
       │
       ▼
Connectivity Check
       │
       ▼
Data Synchronization
       │
       ▼
Backup Validation
       │
       ▼
Monitoring
       │
       ▼
State and Logs
       │
       ▼
Email Notification
```

The workflow is designed to make failures visible instead of silently producing incomplete backups.

Critical failures affect the final backup status and are reported through the monitoring and notification mechanisms.

## Scheduling

The backup process is executed on a weekly schedule using Linux `cron`.

The scheduling layer starts the backup workflow but does not perform the backup itself.

Infrastructure availability can be controlled separately when required by the underlying platform.

## Monitoring

The monitoring layer provides visibility into the operational state of the backup process.

It monitors conditions such as:

* Backup execution status
* Start and completion times
* Successful and failed operations
* Backup server connectivity
* Storage availability
* Script errors
* Infrastructure availability
* Unexpected execution conditions

The monitoring function complements the backup script by helping detect failures that could otherwise remain unnoticed.

Email notifications communicate the final execution result.

## Security

The backup system uses:

* SSH key-based authentication
* Ed25519 keys
* Restricted remote access
* Dedicated backup infrastructure
* Persistent backup storage
* Execution locking
* Exclusion of unnecessary temporary data
* Separation of backup infrastructure from the source server

No credentials, private keys, passwords, tokens, or other sensitive information are stored in the public repository.

Sensitive infrastructure-specific information is intentionally excluded from the documentation.

See [`docs/security.md`](docs/security.md) for the security model.

## Recovery

Backup data is only considered useful when it can be recovered.

The recovery process covers:

1. Identifying the required backup data
2. Validating the selected recovery point
3. Accessing the backup storage
4. Restoring files and directories
5. Restoring databases when applicable
6. Verifying permissions and ownership
7. Validating the recovered environment
8. Recovering to a replacement environment when required

See [`docs/recovery.md`](docs/recovery.md) for the recovery procedures.

## Documentation

| Document                                     | Description                                    |
| -------------------------------------------- | ---------------------------------------------- |
| [`Architecture`](docs/architecture.md)       | System components and their relationships      |
| [`Backup Workflow`](docs/backup-workflow.md) | Complete backup execution flow                 |
| [`Security`](docs/security.md)               | Security controls applied to the backup system |
| [`Recovery`](docs/recovery.md)               | Data recovery and restoration procedures       |

## Design Principles

The system is designed around four principles:

* **Automation** — backups execute according to a predictable schedule.
* **Reliability** — execution is controlled and failures are made visible.
* **Security** — remote access and stored data are protected.
* **Recoverability** — backup data is maintained with restoration in mind.

The current implementation uses AWS for the backup infrastructure, while the backup workflow remains largely independent of the infrastructure provider.

## Need a Similar Backup Solution?

I design and implement automated, secure backup solutions adapted to specific infrastructure requirements.

If you need a similar solution for your Linux infrastructure, feel free to get in touch to discuss your environment, backup requirements, and recovery strategy.

[**Contact me on WhatsApp**](https://wa.me/244926046364?text=Hello%20Manuel%2C%20I%27m%20interested%20in%20a%20backup%20solution%20for%20my%20infrastructure.)
