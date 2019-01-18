# NYULibraries Docker Nginx

Build off base alpine nginx image with additional defaults for kubernetes and security:

- output logs to stdout by default
- runs as non-root user by default
- installed with htpasswd for basic authentication

## Generate secure htpasswd file

```
docker run --rm nyulibraries/nginx:master /tmp/generate_htpasswd.sh $USERNAME
```
