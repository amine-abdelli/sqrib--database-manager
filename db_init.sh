#!/bin/bash

# Build docker image
echo "Building docker image..."
docker build -t sqrib-database--image .

echo "Running container..."
docker run -d -p 5432:5432 -v sqrib-database--volume:/var/lib/postgresql/data --name sqrib-database--container sqrib-database--image

# Create sqrib database
echo "Creating database..."
docker exec -it sqrib-database--container createdb -U postgres sqrib_database

# Configure container
echo "Configuring container..."
docker exec -it sqrib-database--container sh -c "sed -i \"s/^#listen_addresses = 'localhost'/listen_addresses = '*'/\" /var/lib/postgresql/data/postgresql.conf"
docker exec -it sqrib-database--container sh -c "echo 'host    sqrib_database     postgres        172.17.0.1/32         trust' >> /var/lib/postgresql/data/pg_hba.conf"

# Restart container
echo "Restarting container..."
docker restart sqrib-database--container

echo "Process finished with success !"
