FROM alpine:3.2

ENV HTML_PATH=./html
ENV NGINX_CONFIG=./nginx.config/www.exlinetr.com.container

RUN apk add --update nginx && rm -rf /var/cache/apk/*

RUN mkdir -p /apps/www.exlinetr.com/var/html

RUN mkdir -p /tmp/nginx/client-body

#RUN echo "http://dl-4.alpinelinux.org/alpine/v3.3/main" >> /etc/apk/repositories && \
#    apk add --update nginx=1.8.1-r1 && \
#    rm -rf /var/cache/apk/* && \
#    chown -R nginx:www-data /var/lib/nginx

COPY $HTML_PATH /apps/www.exlinetr.com/var/html
#/usr/share/nginx/html 
#/apps/www.exlinetr.com/var/html
COPY $NGINX_CONFIG /etc/nginx/sites-available/
COPY $NGINX_CONFIG /etc/nginx/sites-enabled/

RUN rm -rf /etc/nginx/sites-available/default
RUN rm -rf /etc/nginx/sites-enabled/default

RUN mv /etc/nginx/sites-available/www.exlinetr.com.container /etc/nginx/sites-available/default
RUN mv /etc/nginx/sites-enabled/www.exlinetr.com.container /etc/nginx/sites-enabled/default
RUN rc-service nginx start
EXPOSE 80 
#443

ENTRYPOINT ["nginx", "-g", "daemon off;"]