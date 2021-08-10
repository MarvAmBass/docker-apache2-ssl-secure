# apache2 - (marvambass/apache2-ssl-secure) (+ optional tls & php) on debian [x86 + arm]

_maintained by MarvAmBass_

## What is it

This Dockerfile (available as ___marvambass/apache2-ssl-secure___) gives you a ready to use secured production apache2 server, with php and good configured optional SSL.

View in Docker Registry [marvambass/apache2-ssl-secure](https://hub.docker.com/r/marvambass/apache2-ssl-secure)

View in GitHub [MarvAmBass/docker-apache2-ssl-secure](https://github.com/MarvAmBass/docker-apache2-ssl-secure)

This Dockerfile is based on the [/_/debian:buster/](https://registry.hub.docker.com/_/debian/) Official Image.

## Changelogs

* 2021-08-09
    * complete rework
    * added php, made tls optional
    * healthchecks
    * runit as service mangaer
    * multiarch build

_should still be compatible with the old legacy version of this container_

## Environment variables and defaults

* __DISABLE\_TLS__
 * default: not set - if set yo any value `https` and the `HSTS_HEADERS_*` will be disabled

* __HSTS\_HEADERS\_ENABLE__
 * default: not set - if set to any value the HTTP Strict Transport Security will be activated on SSL Channel

* __HSTS\_HEADERS\_ENABLE\_NO\_SUBDOMAINS__
 * default: not set - if set together with __HSTS\_HEADERS\_ENABLE__ and set to any value the HTTP Strict Transport Security will be deactivated on subdomains


## Running marvambass/apache2-ssl-secure Container

This Dockerfile is not really made for direct usage. It should be used as base-image for your apache2 project. But you can run it anyways.

You should overwrite the _/etc/apache2/external/_ with a folder, containing your apache2 __\*.conf__ files (VirtualHosts etc.) and certs.

    docker run -d \
    -p 80:80 -p 443:443 \
    -v $EXT_DIR:/etc/apache2/external/ \
    marvambass/apache2-ssl-secure

