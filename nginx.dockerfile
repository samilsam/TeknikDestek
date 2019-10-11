FROM nginx:stable

LABEL zinderud  "mokosam@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y supervisor procps net-tools cron apache2-utils \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./configs/supervisord/nginx.conf /etc/supervisord.conf
COPY ./configs/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./configs/nginx/security.conf /etc/nginx/conf.d/security.conf
COPY ./configs/nginx/auto-letsencrypt /opt/letsencrypt/letsencrypt-auto
RUN chmod +x /opt/letsencrypt/letsencrypt-auto

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]