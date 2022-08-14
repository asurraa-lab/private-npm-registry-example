#!usr/bin/sh

build_path=dist/apps/api/main.js
env_path=$ENV
app_name=krubkrong-api


[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
ssh-keyscan -t rsa,dsa ${SERVER} >> ~/.ssh/known_hosts

function remote_script() {
    echo "serving the api-server"
    ssh root@${SERVER} <<+
    cd ~/projects
    cd krubkrong-core
    git pull origin -f

    rm -rf /projects/krubkrong-core/dist/apps/api
    cp -r ~/temp/dist ~/projects/krubkrong-core

    yarn install

    if [[ "$env_path" == "env/api/prod.env" ]]; then
        yarn migration:run prod
    fi;

    pm2 describe ${app_name} > /dev/null
    RUNNING=$?

    if [ "${RUNNING}" -ne 0 ]; then
        npx env-cmd -f ${env_path} pm2 start --name ${app_name} ${build_path}
    else
        pm2 reload ${app_name}
    fi;
    pm2 save --force
+
}

remote_script


