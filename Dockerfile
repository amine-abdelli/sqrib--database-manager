# Use alpine as base image
FROM alpine:latest

# Install postgresql
RUN apk update && \
    apk add postgresql && \
    apk add postgresql-client

# Create directory for postgres data
RUN mkdir -p /var/lib/postgresql/data

# Set permissions on data directory
RUN chown -R postgres:postgres /var/lib/postgresql/data && \
    chmod 700 /var/lib/postgresql/data

# Switch to postgres user
USER postgres

# Initialize postgres database
RUN initdb -D /var/lib/postgresql/data

# Start postgres server
CMD ["postgres", "-D", "/var/lib/postgresql/data"]