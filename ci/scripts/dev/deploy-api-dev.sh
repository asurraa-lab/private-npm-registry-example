#!usr/bin/sh

PROJECT_NAME=${PWD##*/}
PROJECT_APP=api

APP_NAME=${PROJECT_NAME}-${PROJECT_APP}
CONFIG_FILE=${APP_NAME}-dev.conf
BUILD_PARTH=dist/apps/${PROJECT_APP}/main.js

cp -n ci/nginx/dev/$CONFIG_FILE /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/$CONFIG_FILE /etc/nginx/sites-enabled
nginx -t
sudo service nginx restart

yarn && npx nx build ${PROJECT_APP} --prod

pm2 describe ${APP_NAME} > /dev/null
RUNNING=$?
if [ "${RUNNING}" -ne 0 ]; then
  npx env-cmd -f env/${PROJECT_APP}/dev.env pm2 start --name ${APP_NAME} ${BUILD_PARTH}
else
  pm2 reload ${APP_NAME}
fi;

pm2 reload $APP_NAME
pm2 save -f

pm2 ls

# check folder is exist or not
