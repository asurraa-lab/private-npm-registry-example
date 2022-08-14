#!usr/bin/sh
# * init and rsync build to server

PROJECT_DIR=projects/${PROJECT_NAME}
BRANCH_NAME=$BRANCH

[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
ssh-keyscan -t rsa,dsa ${SERVER} >> ~/.ssh/known_hosts

ssh root@${SERVER} <<+
  neofetch
  if [ -d "$PROJECT_DIR" ]; then
      cd projects
      cd ${PROJECT_NAME}
    else
      echo "no project existed | cloning"
      cd projects
      git clone git@github.com:krubkrong/${PROJECT_NAME}.git
      cd ${PROJECT_NAME}
      git checkout -f $BRANCH_NAME
  fi
+

rsync  -azP ${FROM} root@${SERVER}:${TO}


