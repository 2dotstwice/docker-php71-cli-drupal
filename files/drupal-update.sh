#!/bin/bash

cd /usr/share/nginx/html;

if [ ! -e ./core ]; then
  # Drupal 7
  drush fra --yes || true;

  drush -y updb;

   drush -y cc all;
else
  # Drupal 8
  drush -y updb;
  drush -y entity-updates;

  drush en -y config_split || true;
  drush cc drush || true;
  drush csim -y || true;

  drush -y cr;
fi

