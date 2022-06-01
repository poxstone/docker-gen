#!/usr/bin/bash

# rewrite config proxy
if [[ "${PORT_EXPOSE}" != "" ]];then
  echo "" | awk  -v _port="${PORT_EXPOSE}" '{system("sed -iE \"s#listen \+[0-9]\+.\+#listen "_port";#gI\" /etc/nginx/sites-enabled/reverse-proxy.conf")}';
  echo "" | awk  -v _port="${PORT_EXPOSE}" '{system("sed -iE \"s#listen \+\[.\+#listen [::]:"_port";#gI\" /etc/nginx/sites-enabled/reverse-proxy.conf")}';
fi;
if [[ "${HOST_REDIRECT}" != "" ]];then
  echo "" | awk  -v _host="${HOST_REDIRECT}" '{system("sed -iE \"s#proxy_pass.\+#proxy_pass "_host";#gI\" /etc/nginx/sites-enabled/reverse-proxy.conf")}';
fi;

# run nginx
/docker-entrypoint.sh nginx -g 'daemon off;';