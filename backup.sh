#!/bin/bash

# Create a timestamped backup file name
backup_file="sqrib_database_$(date +"%Y-%m-%d_%H-%M-%S").dump"

# Create backups directory if it doesn't exist
mkdir -p backups

# Generate a backup file in the /tmp directory inside the container
docker exec sqrib-database--container pg_dump -U postgres sqrib-database > ./backups/$backup_file

