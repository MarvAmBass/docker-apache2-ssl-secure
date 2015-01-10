FROM ubuntu:14.04
MAINTAINER MarvAmBass

RUN apt-get update && apt-get install -y \
    apache2 \
    openssl

RUN rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/*
RUN mkdir -p /etc/apache2/external

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN sed -i 's/^ServerSignature/#ServerSignature/g' /etc/apache2/conf-enabled/security.conf
RUN sed -i 's/^ServerTokens/#ServerTokens/g' /etc/apache2/conf-enabled/security.conf

RUN echo "ServerSignature Off" >> /etc/apache2/conf-enabled/security.conf
RUN echo "ServerTokens Prod" >> /etc/apache2/conf-enabled/security.conf

RUN a2enmod ssl
RUN a2enmod headers 

RUN echo "SSLProtocol ALL -SSLv2 -SSLv3" >> /etc/apache2/apache2.conf

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD 001-default-ssl.conf /etc/apache2/sites-enabled/001-default-ssl.conf

EXPOSE 80
EXPOSE 443

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
