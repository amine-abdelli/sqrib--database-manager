# Use alpine as base image
FROM alpine:latest

# Install postgresql
RUN apk update && \
    apk add postgresql && \
    apk add postgresql-client

# Create directory for postgres data
RUN mkdir -p /var/lib/postgresql/data

RUN mkdir /run/postgresql && \
    chown postgres:postgres /run/postgresql && \
    chmod 0700 /run/postgresql

# Set permissions on data directory
RUN chown -R postgres:postgres /var/lib/postgresql/data && \
    chmod 700 /var/lib/postgresql/data

# Switch to postgres user
USER postgres

# Initialize postgres database
RUN initdb -D /var/lib/postgresql/data

# Start postgres server
CMD ["postgres", "-D", "/var/lib/postgresql/data"]

# CREATE DATABASE CALLED sqrib-database
# docker exec -it sqrib-database--container createdb -U postgres sqrib-database

# ACCESS POSTGRES DATABASE DOCKER CLI (psql CLI)
# docker exec -it sqrib-database--container psql -U postgres sqrib-database

# Dump database inside the current directory
# docker exec -i sqrib-database--container psql -U postgres -d sqrib-database < ./backups/$file_name

# Restore dump
# docker exec -i sqrib-database--container psql -U postgres -d sqrib-database < ./backups/sqrib_database_2023-03-14_13-58-20.dump

# Restore latest dump (not working yet)
# latest_dump=$(ls -t ./backups/*.dump | head -1)
# docker exec -i sqrib-database--container sh -c "if ! psql -lqt | cut -d \| -f 1 | grep -qw sqrib-database; then createdb sqrib-database; fi && pg_restore -U postgres -d sqrib-database < $latest_dump"

# Update password database
# docker exec -it <container_name> psql -U postgres -c "ALTER USER postgres PASSWORD 'new_password';"

# Database url
# postgresql://postgres:postgres@localhost:5432/sqrib-database
