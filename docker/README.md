# Dockerize Nest Js Applications

## Steps to follow

### Project Configurations
1. Copy `.env.example` to create `.env` and update values accordingly
2. Copy `docker-compose.override.example.yml` to create `docker-compose.override.yml` and update accordingly
3. Go to `.envs` folder
4. Copy relevant `{nest_app}.env.example` to create `{nest_app}.env` file and update accordingly
5. Run `docker network create nestjs-app-network`

### Executing Services
1. Run all services quickly by `docker compose up -d` or...
2. Run specific services only by `docker compose up -d <service1> <service2> ...`

### Terminating Services
1. Stop all services quickly by `docker compose down` or...
2. Stop specific services only by `docker compose rm -sf <service1> <service2> ...`