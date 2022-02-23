FROM nginx:1.20.2

LABEL       Description="nginx Image" \
            Maintainer="<suresh.kvsd@gmail.com>"


RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/

RUN rm /etc/nginx/conf.d/default.conf
COPY project.conf /etc/nginx/conf.d/