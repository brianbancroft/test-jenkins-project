# create an image of a command-line environment suitable for running jest tests on node 18

FROM node:18-alpine as base

ENV APP_HOME="/app"
ARG NPM_TOKEN

WORKDIR ${APP_HOME}

COPY package*.json ${APP_HOME}/

COPY . ${APP_HOME}/

# install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    make \
    python3
