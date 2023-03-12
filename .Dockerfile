# Start with a base image of Ubuntu 20.04
FROM ubuntu:20.04

# Update the apt package manager and install the necessary dependencies
RUN apt-get update && apt-get install -y postgresql

# Create a user and database in PostgreSQL
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
    psql -lqt | cut -d \| -f 1 | grep -qw mydatabase || createdb -O docker mydatabase
    # createdb -O docker mydatabase

# Expose port 5432 to allow connections to the database
EXPOSE 5432

# Specify a volume to persist the database data
VOLUME /var/lib/postgresql/data

# Start the PostgreSQL server when the container starts
CMD ["postgres", "-D", "/var/lib/postgresql/data", "-c", "config_file=/etc/postgresql/postgresql.conf"]

# docker build -t my-postgres-image .
# docker run -d -p 5432:5432 -v my-postgres-volume:/var/lib/postgresql/data --name my-postgres-container my-postgres-image

