FROM node:12.19.0-alpine

LABEL       Description="SmartCowUI Image" \
            Maintainer="<suresh.kvsd@gmail.com>"

EXPOSE 3000

COPY ./core /home/app/core
WORKDIR /home/app/core
COPY ./entrypoint.sh /
 
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
