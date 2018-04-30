FROM 2dotstwice/php71-cli

MAINTAINER Kristof Coomans "kristof@2dotstwice.be"
ENV REFRESHED_AT "2018-04-30 09:07:00"

USER root

ADD ./files/drupal-update.sh /drupal-update.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing --no-install-recommends -q install \
        mysql-client \
        curl \
        wget \
        sed && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /home/www-data && \
    chown www-data:www-data /home/www-data;

USER www-data:www-data

ENV PATH ~/.composer/vendor/bin:$PATH
ENV HOME /home/www-data

RUN composer --verbose global require drush/drush:8.*

USER www-data:www-data

WORKDIR /usr/share/nginx/html

CMD /bin/bash
