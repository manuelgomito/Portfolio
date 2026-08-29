# Backup Workflow

This document describes the operational workflow of the weekly backup system.

The workflow is responsible for executing, monitoring, validating, and reporting the backup operation from the Linux source server to the remote backup server.

## Workflow Overview

The weekly backup follows this sequence:

Cron
  ↓
Backup Script
  ↓
Execution Lock
  ↓
Connectivity Check
  ↓
Data Synchronization
  ↓
Backup Validation
  ↓
Watchdog Monitoring
  ↓
State and Logs
  ↓
Email Notification

The workflow is designed to prevent silent backup failures and provide visibility into the execution result.

## 1. Scheduled Execution

The weekly backup is initiated by Linux `cron`.

`cron` is responsible for starting the backup process according to the configured schedule.

It does not perform the backup operation itself.

Cron
  ↓
Backup Script

## 2. Backup Script

The backup script acts as the main orchestration layer.

It controls the sequence of operations and determines whether the backup can continue or must be marked as failed.

The script is responsible for:

- Starting the backup operation
- Controlling execution flow
- Checking required conditions
- Running synchronization tasks
- Recording results
- Handling failures
- Triggering the final notification

## 3. Execution Lock

Before starting the backup operation, an execution lock prevents multiple backup processes from running simultaneously.

This protects the backup process from overlapping executions caused by:

- A previous backup taking longer than expected
- Manual execution while a scheduled backup is running
- Unexpected repeated execution

The lock is released when the backup process finishes.

## 4. Connectivity Check

Before transferring data, the system verifies connectivity with the remote backup server.

The check confirms that the backup destination is reachable and available for the operation.

If connectivity fails, the backup should not continue as if it were successful.

The failure is recorded and reported.

## 5. Data Synchronization

Data is transferred using `rsync` over SSH.

`rsync` provides efficient synchronization by transferring only the required changes instead of copying the complete dataset during every execution.

The backup process can synchronize multiple backup components, depending on the data included in the backup strategy.

Temporary files, caches, and other unnecessary data can be excluded from synchronization.

## 6. Backup Validation

After synchronization, the backup result is evaluated.

Validation is used to determine whether the expected backup operations completed successfully.

The system does not rely exclusively on the transfer command finishing.

The objective is to distinguish between:

- Successful backup
- Partial backup
- Failed backup
- Backup interrupted before completion

A backup should only be reported as successful when the required operations have completed successfully.

## 7. Watchdog Monitoring

The Watchdog represents the monitoring function of the backup system.

Its role is to observe the backup execution and make abnormal conditions visible.

Monitoring focuses on:

- Backup execution state
- Execution errors
- Failed operations
- Connectivity problems
- Storage availability
- Unexpected execution conditions
- Backup completion status

The Watchdog complements the backup script by providing operational visibility instead of allowing failures to remain unnoticed.

## 8. State and Logs

The backup process records operational information during execution.

Logs provide information about:

- Backup start time
- Backup completion time
- Operations performed
- Successful operations
- Failed operations
- Errors encountered
- Final execution status

Backup state information can also be maintained separately from the operational logs.

This makes it possible to determine the most recent known backup condition.

## 9. Email Notification

After the backup process finishes, an email notification communicates the execution result.

The notification allows the administrator to identify whether the backup completed successfully or requires attention.

Typical outcomes include:

- SUCCESS
- WARNING
- FAILURE

The purpose of notification is to ensure that a backup failure does not remain unnoticed until the data is needed for recovery.

## 10. Failure Handling

The workflow is designed around explicit failure handling.

A failure in a critical stage should affect the final backup status.

Example:

Connectivity Failure
  ↓
Backup Aborted
  ↓
Failure Recorded
  ↓
Notification Sent

The system should not report a successful backup when a required backup component has failed.

## 11. Execution Result

At the end of the workflow, the backup process produces a final execution state.

Backup Execution
  │
  ├── Successful
  │
  ├── Warning / Partial
  │
  └── Failed

The final state is recorded in the backup logs and communicated through the notification mechanism.

## 12. Recovery Relationship

The backup workflow is designed with recovery in mind.

The purpose of the backup is not simply to complete an `rsync` operation.

The final objective is to maintain usable backup data that can be restored when required.

Backup
  ↓
Validation
  ↓
Persistent Storage
  ↓
Recovery

Recovery procedures are documented separately in [`recovery.md`](recovery.md).
