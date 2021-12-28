FROM debian:bullseye

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2

RUN apt-get -q -y update && \
    apt-get --no-install-recommends -y install runit apache2 libapache2-mod-php php openssl php-7.4-xml && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    \
    rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/* && \
    mkdir -p /etc/apache2/external && \
    \
    sed -i 's/^ServerSignature/#ServerSignature/g' /etc/apache2/conf-enabled/security.conf && \
    sed -i 's/^ServerTokens/#ServerTokens/g' /etc/apache2/conf-enabled/security.conf && \
    echo "ServerSignature Off" >> /etc/apache2/conf-enabled/security.conf && \
    echo "ServerTokens Prod" >> /etc/apache2/conf-enabled/security.conf && \
    a2enmod ssl && \
    a2enmod headers && \
    echo "SSLProtocol ALL -SSLv2 -SSLv3" >> /etc/apache2/apache2.conf

COPY . /container/

RUN cp /container/config/sites-enabled/* /etc/apache2/sites-enabled && \
    chmod a+x /container/scripts/entrypoint.sh


HEALTHCHECK --interval=1m --timeout=3s \
  CMD /container/scripts/healthcheck.sh

EXPOSE 80 443

ENTRYPOINT ["/container/scripts/entrypoint.sh"]
