# using staged builds
ARG NODE_VERSION=18.17.1
ARG NODE_IMAGE_TYPE=slim

ARG MAINTAINER="Md. Nazmus Saqib Khan <ratulkhan.jhenidah@gmail.com>"

FROM node:${NODE_VERSION}-${NODE_IMAGE_TYPE}

LABEL maintainer ${MAINTAINER}

# set it as the working directory so that we don't need to keep referencing it
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both yarn.lock, package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY --chown=node:node ./codes/nestjs_app_https_support/tsconfig*.json \
    ./codes/nestjs_app_https_support/package*.json \
    ./codes/nestjs_app_https_support/yarn.lock* \
    ./

# install project dependencies
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i; \
  # Allow install without lockfile, so example works even without Node.js installed locally
  else echo "Warning: Lockfile not found. It is recommended to commit lockfiles to version control." && yarn install; \
  fi

# Copy application sources (.ts, .tsx, js)
COPY --chown=node:node ./codes/nestjs_app_https_support/src/ ./src/
COPY --chown=node:node ./docker/certs/ ./certs

# Build Nest.js based on the preferred package manager
RUN \
  if [ -f yarn.lock ]; then yarn build; \
  elif [ -f package-lock.json ]; then npm run build; \
  elif [ -f pnpm-lock.yaml ]; then pnpm build; \
  else yarn build; \
  fi

ENV NODE_ENV production

# Use the node user from the image (instead of the root user)
USER node

CMD [ "node", "dist/main" ]