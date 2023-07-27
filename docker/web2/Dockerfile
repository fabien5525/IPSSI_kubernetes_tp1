FROM debian:bullseye

RUN apt-get update -y && apt-get install -y nginx

RUN rm -rf /var/www/html/*

COPY ./index.html /var/www/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]