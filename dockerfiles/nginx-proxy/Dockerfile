# Build on top of nginx
FROM nginx

ADD nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/certs
ADD certs/* /etc/nginx/certs/