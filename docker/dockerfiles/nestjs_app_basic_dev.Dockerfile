# Building layer
FROM node:18-alpine AS development

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

# tart Next.js in development mode based on the preferred package manager
CMD \
  if [ -f yarn.lock ]; then yarn run build; \
  elif [ -f package-lock.json ]; then npm run build; \
  elif [ -f pnpm-lock.yaml ]; then pnpm build; \
  else yarn run build; \
  fi
