#!usr/bin/sh

build_path=dist/apps/pos-ui
app_name=krubkrong-pos-ui
port=3700


[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
ssh-keyscan -t rsa,dsa ${SERVER} >> ~/.ssh/known_hosts

function remote_script() {
    echo "serving the pos-ui"
    ssh root@${SERVER} <<+
    cd ~/projects
    cd krubkrong-core
    git pull origin -f

    rm -rf /projects/krubkrong-core/dist/apps/pos-ui
    cp -r ~/temp/dist ~/projects/krubkrong-core

    yarn install

    pm2 serve ${build_path} ${port} --spa --name ${app_name}
    pm2 reload $app_name
    pm2 save --force
+
}

remote_script


