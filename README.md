# NYULibraries Docker Nginx

[![Docker Repository on Quay](https://quay.io/repository/nyulibraries/nginx/status "Docker Repository on Quay")](https://quay.io/repository/nyulibraries/nginx)
[![CircleCI](https://circleci.com/gh/NYULibraries/docker-nginx.svg?style=svg)](https://circleci.com/gh/NYULibraries/docker-nginx)

Build off base alpine nginx image with additional defaults for kubernetes and security:

- output logs to stdout by default
- runs as non-root user by default
- installed with htpasswd for basic authentication
- allow implementers to enable nginx modules

## Generate secure htpasswd file

```
docker run --rm -it nyulibraries/nginx:master /tmp/generate_htpasswd.sh $USERNAME
```
