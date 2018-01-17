#!/bin/bash

# debug mode
set -ex

if [ -z "$1" ]; then
    echo "Must be set branch to deploy (ex: task_1809)";
    exit 1;
fi

if [ -z "$2" ]; then
    echo "Must be set port to deploy (ex: 8080|8686|8888|9090|9292|9393|9494)";
    exit 1;
fi

REMOTE_USER=ngo.dinh.ngoc
REMOTE_HOST=10.0.1.179
REMOTE_DEST="/var/www/html/csu-portal/csu-"$2

PRIVATE_KEY=${PRIVATE_KEY:-"~/.ssh/id_rsa"}

echo $PRIVATE_KEY;

cat <<DEPLOY | ssh -i $PRIVATE_KEY -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST
cd $REMOTE_DEST
git fetch
git checkout -f $1
./deploy.sh
DEPLOY