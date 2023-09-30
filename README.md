# Sqrib Database Management System

## Overview

This repository contains a set of automation scripts designed to manage a PostgreSQL database running in a Docker container. The various utilities offer features such as:

- Automatic backups
- Backup aging and cleanup
- Database restoration
- Initialization and configuration of a PostgreSQL database in a Docker container
- Logging of backup activities

## Repository Contents

The repository consists of the following key files and scripts:

### Scripts

- `db_init.sh`: Initializes and configures a PostgreSQL database within a Docker container.
- `db_backup.sh`: Handles the backup of the PostgreSQL database.
- `db_restore.sh`: Restores the PostgreSQL database from the most recent backup.
- `backup-cron.js`: Schedules and automates the running of `db_backup.sh` using a Node.js cron job.

### Utility and Configuration

- `utils.js`: Provides utility functions for logging and file cleanup.
- `utils.json`: Configuration file for specifying utility settings.

### Others

- `Dockerfile`: Contains the setup for the Docker image used for the PostgreSQL database.
- `.gitignore`: Specifies files and directories to ignore in git.
- `package.json` and `yarn.lock`: Node.js package information and lock file for dependency management.

## Features

### Automated Backups

The backup script (`db_backup.sh`) and the Node.js cron job (`backup-cron.js`) work together to automate the database backup process. Backups are triggered every 10 seconds and saved with a timestamp.

### Backup Cleanup

The system automatically deletes backups that are older than 7 days to conserve storage space.

### Easy Database Restoration

The `db_restore.sh` script can quickly restore the database to the state of the most recent backup.

### Logging

All backup-related activities are logged to `backup.log`, making it easier to track operations and troubleshoot issues.

## Dependencies

- Docker for containerization
- Node.js for running the cron job
- PostgreSQL database engine
