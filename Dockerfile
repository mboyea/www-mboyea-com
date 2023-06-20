# create docker image from ubuntu base with bullseye slim node runtime dependencies
# SOURCE: https://github.com/BretFisher/nodejs-rocks-in-docker
FROM node:20.2.0-bullseye-slim AS node
FROM ubuntu:focal-20230412 AS base
COPY --from=node /usr/local/include/ /usr/local/include/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /usr/local/bin/ /usr/local/bin/
# refresh corepack to fix simlinks for npx, yarn, & pnpm
RUN corepack disable && corepack enable
# create server group & node user, then create app directory
RUN groupadd --gid 1000 server \
    && useradd --uid 1000 --gid server --shell /bin/bash --create-home node \
    && mkdir /app \
    && chown -R node:server /app

# create prod environment
FROM base AS prod
# move to app directory as user node
WORKDIR /app
USER node
# install pnpm
RUN curl https://get.pnpm.io/install.sh | env PNPM_VERSION=8.6.2 sh -
# install app dependencies
COPY --chown=node:server pnpm-lock.yaml ./
RUN pnpm fetch --prod
RUN pnpm install -r --offline --prod
# copy app files
COPY --chown=node:server build build
COPY --chown=node:server package.json ./
# start server
ENV HOST 0.0.0.0
ENV PORT 8080
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/node", "./build"]
