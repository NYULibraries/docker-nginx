ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}-alpine

RUN apk add --no-cache --update apache2-utils

# chown necessary files
RUN touch /var/run/nginx.pid \
  && chown -R nginx:nginx /var/run/nginx.pid \
  && chown -R nginx:nginx /var/cache/nginx

# use configs that default to 8080 and output error logs to stdout
COPY --chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY --chown=nginx:nginx enabled-modules.conf /etc/nginx/enabled-modules.conf

# setup htpasswd
RUN mkdir /etc/apache2 && ln -s /etc/apache2/private/htpasswd /etc/apache2/.htpasswd \
  && chown -R nginx:nginx /etc/apache2

# add script to securely generate htpasswd
COPY --chown=nginx:nginx script/generate_htpasswd.sh /tmp/generate_htpasswd.sh

# use non-root user
USER nginx
