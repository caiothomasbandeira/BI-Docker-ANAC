FROM postgres:16-alpine

RUN apk add --no-cache python3

COPY init/ /docker-entrypoint-initdb.d/
