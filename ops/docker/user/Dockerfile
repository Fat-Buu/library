FROM mysql:9.3.0

ENV MYSQL_ROOT_PASSWORD=my_secret_password
ENV MYSQL_DATABASE=user_db

ENV MYSQL_USER=user_user
ENV MYSQL_PASSWORD=user_password

COPY ./sql/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

# BUILD
# docker build -t mysql-user-db:1.0 .
# RUN
# docker run -d -p 3307:3306 --name mysql-user-db mysql-user-db:1.0