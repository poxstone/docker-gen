FROM ubuntu:17.04
WORKDIR /home/developer
ENV HOME /home/developer
RUN apt-get update && apt-get upgrade -y && \
  #install vim and tools
  apt-get install -y --no-install-recommends apt-utils && \
  apt-get install -y sudo grep sed git vim tmux software-properties-common curl dnsutils ssh nmap iputils-tracepath tcpdump netdiscover wget net-tools tree whois python && \
  #prepare user dev
  export uid=1000 gid=1000 && \
  mkdir -p /home/developer && \
  echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
  echo "developer:x:${uid}:" >> /etc/group && \
  echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
  chmod 0440 /etc/sudoers.d/developer && \
  chown ${uid}:${gid} -R /home/developer; \
  mkdir -p ~/.vim/autoload/ ~/.vim/bundle/; \
  mkdir ~/Documents; \ 
  cp -rf /root/.bashrc ~/; \ 
  su develop; \
  cd ~; \
  #install vim
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim; \
  cd ~/.vim/bundle/; \
  for i in https://github.com/mattn/emmet-vim \
    https://github.com/scrooloose/nerdtree.git \
    https://github.com/tomtom/tlib_vim \
    https://github.com/leafgarland/typescript-vim \
    https://github.com/MarcWeber/vim-addon-mw-utils \
    https://github.com/vim-scripts/vim-auto-save \
    https://github.com/digitaltoad/vim-pug \
    https://github.com/tpope/vim-sensible \
    https://github.com/wavded/vim-stylus.git; \
  do git clone $i;done; \
  cd ~; \
  if [ ! -e ~/.vimrc ];then \
    touch ~/.vimrc; \
    chmod 775 ~/.vimrc; \
  fi; \
  if ! grep ~/.vimrc -e "execute pathogen#infect()";then \
    printf "set enc=utf-8\nset fileencoding=utf-8set hls\nset number\nset relativenumber\nset tabstop=2\nset shiftwidth=2\nset expandtab\nset cindent\nset wrap! \n" >> ~/.vimrc; \
    printf "xnoremap p pgvy\nnnoremap <C-H> :Hexmode<CR>\ninoremap <C-H> <Esc>:Hexmode<CR>\nvnoremap <C-H> :<C-U>Hexmet rela  de<CR> \n" >> ~/.vimrc; \
    printf "let mapleader = \",\"\nnmap <leader>ne :NERDTreeToggle<cr> \n" >> ~/.vimrc; \
    printf "execute pathogen#infect() \ncall pathogen#helptags() \nsyntax on \nfiletype plugin indent on \n" >> ~/.vimrc; \
  fi; \
#install node
RUN sudo apt-get install -y build-essential libssl-dev && . ~/.bashrc; \
  if nvm --version && stylus --version && pug --version;then \
    echo "node not need instalation"; \
  else \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash && \
    . ~/.nvm/nvm.sh && . ~/.bashrc; \
    nvm install 8 && nvm use 8 && nvm alias default $(nvm current) && \
    npm i -g stylus nib pug-cli less less-prefixer watch-less http-server bower; \
  fi; \
  sudo chown -R developer:developer .;
#install gcloud
RUN sudo su; \
  apt-get update && apt-get upgrade -y && \
  apt-get -qqy update && apt-get install -qqy curl gcc python-dev python-setuptools apt-transport-https lsb-release openssh-client git && \ 
  easy_install -U pip && \ 
  pip install -U crcmod && \ 
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \ 
  echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \ 
  wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \ 
  apt-get update && \
  apt-get install -y google-cloud-sdk google-cloud-sdk-app-engine-python google-cloud-sdk-datalab google-cloud-sdk-pubsub-emulator google-cloud-sdk-datalab google-cloud-sdk-datastore-emulator google-cloud-sdk-pubsub-emulator google-cloud-sdk-bigtable-emulator google-cloud-sdk-cbt kubectl google-cloud-sdk-app-engine-go google-cloud-sdk-app-engine-java && \ 
  gcloud config set core/disable_usage_reporting true && \ 
  gcloud config set component_manager/disable_update_check true && \ 
  gcloud config set metrics/environment github_docker_image; \ 
  sudo chown -R developer:developer .; \ 
  cp -rf ./.bashrc /root/.bashrc;
#install java
RUN sudo su; \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y  && \ 
  apt-get install -y unzip && \
  add-apt-repository ppa:webupd8team/java -y && \
  apt-get update && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean; \
  echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::');" >> ~/.bashrc;
#gradle
#  curl -O https://downloads.gradle.org/distributions/gradle-4.1-bin.zip; \
#  unzip gradle-4.1-bin.zip && \ 
#  mkdir -p /opt/gradle; \ 
#  mv gradle-4.1-bin /opt/gradle/; \ 
#  echo "export PATH=\$PATH:/opt/gradle/gradle-4.1/bin" >> ~/.bashrc;
#mysql
#ENV MYSQL_USER=mysql \
#  MYSQL_DATA_DIR=/var/lib/mysql \
#  MYSQL_RUN_DIR=/run/mysqld \
#  MYSQL_LOG_DIR=/var/log/mysql
#RUN sudo su; \
#  apt-get update && apt-get upgrade -y && \
#  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client && \
#  rm -rf ${MYSQL_DATA_DIR} && \
#  rm -rf /var/lib/apt/lists/*;

#COPY ./entrypoint.sh /sbin/entrypoint.sh
#EXPOSE 3306/tcp
EXPOSE 8080/tcp
EXPOSE 5000/tcp
EXPOSE 8081/tcp
EXPOSE 8000/tcp
EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 22/tcp
USER developer
#CMD group=$(ls -l $HOME/.ssh/id_rsa | awk '{print($3)}') && chmod 755 /sbin/entrypoint.sh && groupadd usermod -a -g $group $(id -un)
CMD bash
#Docker alias
#function cloud-dev {
#  name=$(if [ $1 ];then echo $1;else echo "cloud-dev-a";fi;);
#  port=$(if [ $2 ];then echo $2;else echo 8;fi;);
#  tag=$(if  [ $3 ];then echo $3;else echo latest;fi;);
#  #docker rm ${name} 1&2> /dev/null;
#  docker run -it --rm \
#    --name ${name} \
#    -v $HOME/Projects:/home/developer/Projects \
#    -v $HOME/run:/home/developer/run \
#    -v $HOME/Documents:/home/developer/Documents/\
#    -v $HOME/bin:/home/developer/bin \
#    -v $HOME/.gitconfig:/home/developer/.gitconfig \
#    -v $HOME/.ssh:/home/developer/.ssh \
#    -v $HOME/.boto:/home/developer/.boto \
#    -v $HOME/.config/gcloud:/home/developer/.config/gcloud \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -p ${port}080:8080 \
#    -p ${port}081:8081 \
#    -p ${port}000:8000 \
#    -p ${port}500:5000 \
#    -p ${port}122:22 \
#    -p ${port}180:80 \
#    -p ${port}443:443 \
#    -e DISPLAY=$DISPLAY \
#    poxstone/cloud-dev:${tag} bash;
#}

