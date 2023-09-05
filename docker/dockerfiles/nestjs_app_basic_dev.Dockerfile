# Building layer
ARG NODE_VERSION=18
ARG NODE_IMAGE_TYPE=alpine
ARG MAINTAINER="Md. Nazmus Saqib Khan <ratulkhan.jhenidah@gmail.com>"

FROM node:${NODE_VERSION}-${NODE_IMAGE_TYPE} AS development

WORKDIR /app

# Copy configuration files
COPY ./codes/nestjs_app_basic/tsconfig*.json \
    ./codes/nestjs_app_basic/package*.json \
    ./codes/nestjs_app_basic/yarn.lock* \
    ./

RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i; \
  # Allow install without lockfile, so example works even without Node.js installed locally
  else echo "Warning: Lockfile not found. It is recommended to commit lockfiles to version control." && yarn install; \
  fi

# Copy application sources (.ts, .tsx, js)
COPY ./codes/nestjs_app_basic/src/ ./src/

# Build Nest.js based on the preferred package manager
CMD \
  if [ -f yarn.lock ]; then yarn run build; \
  elif [ -f package-lock.json ]; then npm run build; \
  elif [ -f pnpm-lock.yaml ]; then pnpm build; \
  else yarn run build; \
  fi
