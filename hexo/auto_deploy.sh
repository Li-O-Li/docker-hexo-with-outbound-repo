#!/bin/sh
# copy /hexo/public/ folder to remote path.
DEST_FOLDER="${DEPLOY_USER_NAME}@${DEPLOY_IP}:${DEPLOY_FOLDER}"

# create dest folder and transfer generated html files.
echo "[`date`]Try logging into deploy server..."
ssh -p $DEPLOY_SSH_PORT ${DEPLOY_USER_NAME}@${DEPLOY_IP} "mkdir -p ${DEPLOY_FOLDER}"
echo "[`date`]Login to deploy server successfully, copying files..."
scp -qrC -P $DEPLOY_SSH_PORT /hexo_build/public/* $DEST_FOLDER
echo "[`date`]Successfully deployed!"