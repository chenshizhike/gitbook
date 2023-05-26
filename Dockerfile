FROM node:10.24.1-alpine

EXPOSE 4000

ENV GITBOOK_VERSION=3.2.3

ENV NPM_CONFIG_LOGLEVEL=info PUPPETEER_SKIP_DOWNLOAD=true

ENV USERNAME=node GID=1000 UID=1000

ENV BOOKDIR /gitbook

RUN mkdir $BOOKDIR \
    && chown -R $UID:$GID $BOOKDIR \
    && npm install gitbook-cli -g \
    && npm cache clean --force \ 
    && rm -rf /tmp/*
    
USER $USERNAME

RUN gitbook fetch $GITBOOK_VERSION \ 
    && npm cache clean --force \ 
    && rm -rf /tmp/*

WORKDIR $BOOKDIR

ENTRYPOINT ["gitbook"]
