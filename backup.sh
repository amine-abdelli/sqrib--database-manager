#!/bin/bash

# Create a timestamped backup file name
backup_file="mydatabase_$(date +"%Y-%m-%d_%H-%M-%S").dump"

# Generate a backup file in the /tmp directory inside the container
docker exec my-postgres-container pg_dump -U postgres -Fc mydatabase > /tmp/$backup_file

# Copy the backup file from the container to a backup directory on the VPS
docker cp my-postgres-container:/tmp/$backup_file /path/to/databaseBackups/

# Delete the temporary backup file from the container
docker exec my-postgres-container rm /tmp/$backup_file
