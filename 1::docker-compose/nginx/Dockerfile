FROM nginx:1.15.8

LABEL       Description="nginx Image" \
            Maintainer="<suresh.kvsd@gmail.com>"

RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/
RUN rm /etc/nginx/conf.d/default.conf
COPY server.conf /etc/nginx/conf.d/