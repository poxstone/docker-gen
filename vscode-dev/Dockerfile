FROM "codercom/code-server"
USER root
ENV VS_USER='coder'
#ENV VS_USER_CODE='1004'
#ENV VS_GROUP_CODE='1005'

RUN apt-get -y update && apt-get -y upgrade;
# basic tools
RUN apt-get install -y vim nano tmux htop iotop lynx nmap whois tcpdump iotop \
    grep sed tmux software-properties-common curl dnsutils ssh nmap \
    iputils-tracepath tcpdump netdiscover wget net-tools tree wget iputils-ping
# build tools
RUN apt-get install -y build-essential libssl-dev openssh-client openssh-server \
    libtool pkg-config libgeos-*
# docker in docker
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables; \
    curl -sSL https://get.docker.com/ | sh; \
    mkdir /var/lib/docker; \
    usermod -aG docker $VS_USER; \
    newgrp docker;

# python tools
RUN apt-get -y install python python-pip && \
    pip install --upgrade pip setuptools ez_setup setuptools pyudev cryptography \
    apache-beam timezonefinder==3.0.0 pytz 'apache-beam[gcp]' apache-beam[test] apache-beam[docs] \
    pyOpenSSL requests ansible pylint jsonschema flask gunicorn virtualenv simple-http-server && \
    apt-get -y install apt-utils python3 python3-pip && \
    pip3 install --upgrade pip setuptools ez_setup setuptools pyudev cryptography \
    apache-beam timezonefinder==3.0.0 pytz 'apache-beam[gcp]' apache-beam[test] apache-beam[docs] \
    pyOpenSSL requests ansible pylint jsonschema flask gunicorn virtualenv httpserver
# install various tools
RUN apt-get -y install postgresql-client redis-tools mariadb-client
# node js and packages 12
RUN curl -sL "https://deb.nodesource.com/setup_12.x" | bash && \
    apt-get install -y nodejs
#    npm install -g typescript http-server stylus pug nib grunt gulp
# install aditional languages
RUN apt-get -y install golang-go #default-jdk
RUN apt install -y wget gnupg software-properties-common && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add - && \
    sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt update -y && apt install adoptopenjdk-8-hotspot -y
# google services
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    sudo apt-get -y update && sudo apt-get -y install google-cloud-sdk && \
    apt-get install -y kubectl google-cloud-sdk google-cloud-sdk-app-engine-grpc \
#google-cloud-sdk-pubsub-emulator \
#google-cloud-sdk-app-engine-java \
#google-cloud-sdk-datastore-emulator \
    google-cloud-sdk-cloud-build-local \
    google-cloud-sdk-app-engine-go \
    google-cloud-sdk-datalab \
    google-cloud-sdk-app-engine-python google-cloud-sdk-cbt \
    google-cloud-sdk-bigtable-emulator google-cloud-sdk-app-engine-python-extras

# the UID is same than user owner volume. Customize "1005" with show docker UID owner folder
#RUN usermod -u $VS_USER_CODE $VS_USER && \
#    groupmod -g $VS_GROUP_CODE $VS_USER
USER $VS_USER

EXPOSE 8443
EXPOSE 8080
EXPOSE 8081

ENTRYPOINT ["dumb-init", "code-server"]
