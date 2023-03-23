#!/bin/bash

# Find the latest backup created in the backups folder. It works by using the ls command with the -1t flag, which 
# lists files in a single-column format (-1) and sorts them by modification time (-t). The head -n1 command then
# selects the first file in the list, which is the latest created file.
latest_backup=$(basename "$(ls -1t "./backups/sqrib_database_backup_"*".dump" | head -n1)")

# Restore database
echo "Restoring database ..."
docker cp ./backups/$latest_backup sqrib-database--container:/tmp/$latest_backup
docker exec -it sqrib-database--container dropdb -U postgres sqrib_database
docker exec -it sqrib-database--container createdb -U postgres sqrib_database
echo "Restoring backup $latest_backup"
# docker exec sqrib-database--container psql -U postgres sqrib_database < /tmp/$backup_file
docker exec -it sqrib-database--container psql -U postgres sqrib_database -f /tmp/$latest_backup