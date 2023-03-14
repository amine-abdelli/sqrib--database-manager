# Start with a base image of Ubuntu 20.04
# FROM alpine:3.13

# Update the apt package manager and install the necessary dependencies
# RUN apk update && \
    # apk add --no-cache postgresql postgresql-client && \
    # rm -rf /var/cache/apk/*

# Create a user and database in PostgreSQL
# USER postgres
# RUN /etc/init.d/postgresql start && \
    # psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
    # psql -lqt | cut -d \| -f 1 | grep -qw sqrib-database || createdb -O docker sqrib-database

# Expose port 5432 to allow connections to the database
# EXPOSE 5432

# Specify a volume to persist the database data
# VOLUME /var/lib/postgresql/data

# Start the PostgreSQL server when the container starts
# CMD ["postgres", "-D", "/var/lib/postgresql/data", "-c", "config_file=/etc/postgresql/postgresql.conf"]

# docker build -t sqrib-database--image .
# docker run -d -p 5432:5432 -v sqrib-database--volume:/var/lib/postgresql/data --name sqrib-database--container sqrib-database--image
# postgresql://docker:docker@localhost:5432/sqrib-database

# Start with a base image of Alpine Linux
FROM alpine:3.13

RUN apk add --no-cache libc6-compat && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ libintl && \
    apk add --no-cache --update-cache postgresql-client && \
    apk add --no-cache --virtual .gettext gettext && \
    ln -s /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .gettext && \
    rm -rf /var/cache/apk/*

# Create a user and database in PostgreSQL
RUN addgroup -S postgres && adduser -S postgres -G postgres
USER postgres
RUN initdb -D /var/lib/postgresql/data && \
    chown -R postgres:postgres /var/lib/postgresql/data && \
    pg_ctl -D /var/lib/postgresql/data start && \
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
    psql -lqt | cut -d \| -f 1 | grep -qw sqrib-database || createdb -O docker sqrib-database

# Expose port 5432 to allow connections to the database
EXPOSE 5432

# Specify a volume to persist the database data
VOLUME /var/lib/postgresql/data

# Start the PostgreSQL server when the container starts
CMD ["postgres", "-D", "/var/lib/postgresql/data", "-c", "config_file=/etc/postgresql/postgresql.conf"]
