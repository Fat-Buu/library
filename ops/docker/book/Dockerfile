FROM mysql:9.3.0

ENV MYSQL_ROOT_PASSWORD=my_secret_password
ENV MYSQL_DATABASE=book_db

ENV MYSQL_USER=book_user
ENV MYSQL_PASSWORD=book_password

COPY ./sql/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

# BUILD
# docker build -t mysql-book-db:1.0 .
# RUN
# docker run -d -p 3306:3306 --name mysql-book-db mysql-book-db:1.0