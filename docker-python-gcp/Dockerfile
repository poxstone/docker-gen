FROM gcr.io/google.com/cloudsdktool/cloud-sdk:375.0.0

ENV VS_USER='cloudsdk'

USER root
RUN apt-get update && apt-get upgrade -y; apt install -y nano vim git
RUN pip3 install virtualenv

USER $VS_USER
WORKDIR /home/$VS_USER