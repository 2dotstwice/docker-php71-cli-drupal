FROM 2dotstwice/php71-cli

MAINTAINER Kristof Coomans "kristof@2dotstwice.be"
ENV REFRESHED_AT "2017-02-16 08:08:00"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing -q install mysql-client curl wget sed

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:8.*

RUN touch ~/.profile

env PATH ~/.composer/vendor/bin:$PATH

# ensure console_table is installed
RUN ~/.composer/vendor/bin/drush --debug

ADD ./files/drupal-update.sh /drupal-update.sh

CMD /bin/bash