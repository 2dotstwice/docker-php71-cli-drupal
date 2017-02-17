#!/bin/bash

cd /usr/share/nginx/html;

if [ ! -e ./core ]; then
  sudo -u www-data drush fra --yes || true;
fi

drush -y updb;

# Config sync
if [ -e ./core ]; then
  drush en -y config_split || true;
  drush cc drush || true;
  drush csim -y || true;
fi

# Final cache clear / rebuild
if [ ! -e ./core ]; then
  drush -y cc all;
else
  drush -y cr;
fi
