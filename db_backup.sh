#!/bin/bash

# Create a timestamped backup file name
backup_file="sqrib_database_backup_$(date +"%Y-%m-%d_%H-%M-%S").dump"

# Create backups directory if it doesn't exist
mkdir -p backups

# Create database backup in backups directory
docker exec sqrib-database--container pg_dump -U postgres sqrib_database > ./backups/$backup_file

