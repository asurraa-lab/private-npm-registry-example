#!usr/bin/sh

PROJECT_APP=dashboard

APP_NAME=${PROJECT_NAME}-${PROJECT_APP}
CONFIG_FILE=${APP_NAME}-dev.conf

BUILD_PATH=dist/apps/${PROJECT_APP}


[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
ssh-keyscan -t rsa,dsa ${SERVER} >> ~/.ssh/known_hosts

function remote_script() {
    echo "serving the ${PROJECT_APP}"
    ssh root@${SERVER} <<+
    cd ~/projects
    cd ${PROJECT_NAME}
    git pull origin -f

    rm -rf /projects/${PROJECT_NAME}/dist/apps/${PROJECT_APP}
    cp -r ~/temp/dist ~/projects/${PROJECT_NAME}

    cp -n ci/nginx/dev/${CONFIG_FILE} /etc/nginx/sites-available
    ln -s /etc/nginx/sites-available/${CONFIG_FILE} /etc/nginx/sites-enabled
    nginx -t
    sudo service nginx restart

    yarn install

    pm2 describe ${APP_NAME} > /dev/null
    RUNNING=$?
    if [ "${RUNNING}" -ne 0 ]; then
      npx env-cmd -f env/${PROJECT_APP}/dev.env pm2 start --name ${APP_NAME} ${BUILD_PARTH}
    else
      pm2 reload ${APP_NAME}
    fi;

    pm2 save --force
+
}

remote_script


