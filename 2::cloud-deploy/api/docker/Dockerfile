FROM ubuntu:20.04

LABEL       Description="SmartCowApp Image" \
            Maintainer="<suresh.kvsd@gmail.com>"
        

RUN apt-get update && apt-get install -y python3 python3-dev python3-pip

COPY ./core/requirements.txt /core/

WORKDIR /core

ARG DEBIAN_FRONTEND=noninteractive    
RUN pip install -r requirements.txt 

EXPOSE 8000

# COPY ./core/__init__.py /core
COPY ./core /core
COPY ./entrypoint.sh /
 
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]