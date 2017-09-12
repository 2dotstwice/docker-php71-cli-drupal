FROM 2dotstwice/php71-cli

MAINTAINER Kristof Coomans "kristof@2dotstwice.be"
ENV REFRESHED_AT "2017-02-16 08:08:00"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing --no-install-recommends -q install \
        mysql-client \
        curl \
        wget \
        sed && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    composer global require drush/drush:8.* && \
    rm -rf /var/lib/apt/lists/*

RUN touch ~/.profile

ENV PATH ~/.composer/vendor/bin:$PATH

# ensure console_table is installed
RUN ~/.composer/vendor/bin/drush --debug

ADD ./files/drupal-update.sh /drupal-update.sh

CMD /bin/bash