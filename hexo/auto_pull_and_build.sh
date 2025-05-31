#!/bin/sh

# recreate /hexo_build directory and clone /hexo into it to avoid mount permission issues.
mkdir -p /hexo_build
cd /hexo_build

echo "[`date`]Cloning /hexo into /hexo_build..."
rsync -a --exclude='public' --delete /hexo/ ./
chown -R root:root /hexo_build
chmod -R 755 /hexo_build
echo "[`date`]Cloning and setting permissions done."

# del clone directory if exists
if [ -d "/tmp/source_files" ]; then
  rm -rf /tmp/source_files
fi

# clone source files from Gitea repository
echo "[`date`]Cloning repo into /tmp/source_files..."
REPO_URL="ssh://${REPO_USER_NAME}@${REPO_IP}:${REPO_SSH_PORT}/${REPO_NAME}.git"
git clone --depth=1 $REPO_URL /tmp/source_files

# move files to hexo folder.
echo "[`date`]Syncing repo files from /tmp/source_files/ to build folder..."
rsync -a --exclude='.git' --remove-source-files /tmp/source_files/ ./
chmod -R 755 /hexo_build
rm -rf /tmp/source_files
echo "[`date`]Syncing done!..."

echo "[`date`]Starting html generation..."
hexo clean
hexo generate
echo "[`date`]Html generation done!"
rsync -a --delete --no-o --no-g /hexo_build/public/ /hexo/public/
echo "[`date`]Successfully synced generated htmls from /hexo_build/public to /hexo/public"