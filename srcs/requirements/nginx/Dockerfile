FROM debian:buster

# install nginx and openssl
RUN apt-get update
RUN apt-get install -y \
    nginx \
    nano \
    openssl \
    procps

# generate a self-signed ssl certificate
RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
        -keyout /etc/ssl/private/localhost.key \
        -out /etc/ssl/certs/localhost.crt

# copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/conf.d/

# expose port 443 ( https )
EXPOSE 443

# start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
