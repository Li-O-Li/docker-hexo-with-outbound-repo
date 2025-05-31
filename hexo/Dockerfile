# Create HEXO Container Based on Node 22 LTS
FROM node:22-alpine

# allow /hexo to mount on external disk
WORKDIR /hexo_backup

ENV REPO_SSH_PORT="22"
ENV DEPLOY_SSH_PORT="22"

# Install dependencies.
# RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories
RUN apk add --no-cache git bash curl socat openssh rsync && \
    npm install -g hexo-cli && \
    hexo init . && \
    npm install && \
    touch .delete_me_to_restore

# Copy scripts into container and set permissions.
COPY auto_deploy.sh auto_pull_and_build.sh handle_webhook.sh entry.sh ssh_setup.sh webhook_listener.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_deploy.sh && \
    chmod +x /usr/local/bin/auto_pull_and_build.sh && \
    chmod +x /usr/local/bin/handle_webhook.sh && \
    chmod +x /usr/local/bin/entry.sh && \
    chmod +x /usr/local/bin/ssh_setup.sh && \
    chmod +x /usr/local/bin/webhook_listener.sh

# Run webhook listener.
ENTRYPOINT ["/usr/local/bin/entry.sh"]
