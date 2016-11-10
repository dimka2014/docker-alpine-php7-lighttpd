FROM alpine:edge

MAINTAINER Dmitriy Belyaev "dimabelyaev27@gmail.com"

RUN apk --update add \
    lighttpd \
    php7 \
    php7-iconv \
    php7-session \
    php7-json \
    php7-curl \
    php7-xml \
    php7-imap \
    php7-cgi \
    php7-fpm \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom \
    php7-phar \
    fcgi \
    && rm -rf /var/cache/apk/*

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
RUN mkdir -p /var/www/web/ && \ 
    echo "<?php phpinfo();" > /var/www/web/index.php && \
    adduser www-data -G www-data -H -s /bin/false -D && \
    ln -s /usr/bin/php-cgi7 /usr/bin/php-cgi && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    mkdir -p /run/lighttpd/ && \
    chown www-data. /run/lighttpd/

EXPOSE 80

CMD php-fpm7 -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf

