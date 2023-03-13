#!/bin/bash

# # Create a timestamped backup file name
backup_file="sqrib_database_$(date +"%Y-%m-%d_%H-%M-%S").dump"

# # Generate a backup file in the /tmp directory inside the container
docker exec postgres-database-container pg_dump -U postgres -Fc sqrib_database > /tmp/$backup_file

# # Copy the backup file from the container to a backup directory on the VPS
docker cp postgres-database-container:/tmp/$backup_file /path/to/databaseBackups/

# # Delete the temporary backup file from the container
docker exec postgres-database-container rm /tmp/$backup_file
