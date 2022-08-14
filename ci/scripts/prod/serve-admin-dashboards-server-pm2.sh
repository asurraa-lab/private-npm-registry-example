#!usr/bin/sh

build_path=dist/apps/admin-dashboard
app_name=krubkrong-admin-dashboard
port=3500


[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
ssh-keyscan -t rsa,dsa ${SERVER} >> ~/.ssh/known_hosts

function remote_script() {
    echo "serving the dashboard-ui"
    ssh root@${SERVER} <<+
    cd ~/projects
    cd krubkrong-core
    git pull origin -f

    rm -rf /projects/krubkrong-core/dist/apps/admin-dashboard
    cp -r ~/temp/dist ~/projects/krubkrong-core

    yarn install

    pm2 serve ${build_path} ${port} --spa --name ${app_name}
    pm2 reload $app_name
    pm2 save --force
+
}

remote_script


