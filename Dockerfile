FROM nginx:1.15.5-alpine

RUN apk add --no-cache --update apache2-utils

# chown necessary files
RUN touch /var/run/nginx.pid \
  && chown -R nginx:nginx /var/run/nginx.pid \
  && chown -R nginx:nginx /var/cache/nginx

# use configs that default to 8080 and output error logs to stdout
COPY --chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx nginx.vh.default.conf /etc/nginx/conf.d/default.conf

# setup htpasswd
RUN mkdir /etc/apache2 && ln -s /etc/apache2/private/htpasswd /etc/apache2/.htpasswd \
  && chown -R nginx:nginx /etc/apache2

# add script to securely generate htpasswd
COPY --chown=nginx:nginx script/generate_htpasswd.sh /tmp/generate_htpasswd.sh

# security scan
ARG AQUA_MICROSCANNER_TOKEN
RUN apk add --no-cache ca-certificates \
  && wget -O /microscanner https://get.aquasec.com/microscanner \
  && chmod +x /microscanner \
  && /microscanner ${AQUA_MICROSCANNER_TOKEN} \
  && rm -rf /microscanner \
  && apk del ca-certificates

# use non-root user
USER nginx
