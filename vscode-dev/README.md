# vs coder server
- vs coder server
- python 2.7, 3.7
- java 1.8
- node 12
- go 1.10.4
- gcloud 247 and tools
- others: git, vim, curl, nmap, deb builds, ssh, tcpdump, whois, yarn
- ***Autocreate:*** `./auto_prepare.sh`

## Docker origin
```bash
git clone https://github.com/cdr/code-server.git;
MANIFIEST="./code-server/scripts/webpack.client.config.js"
grep -n "background_color" $MANIFIEST | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/,.*$/, orientation: "any",/' $MANIFIEST;

docker build -t poxstone/vscode -f ./code-server/Dockerfile ./code-server/;
```

## docker build

ˊˊˊbash
docker build -t poxstone/code-server:latest ./;
ˊˊˊ

## run image

ˊˊˊbash
#vscode-server $(pwd)
function vscode-server {
  [[ $1 == '' ]] && WORK_DIR="$(pwd)" || WORK_DIR="$1";
  echo "WORK_DIR: $WORK_DIR";
  docker run -it --rm --name code-server \
    -p 8443:8443 \
    -p 8080:8080 \
    -p 8081:8081 \
    -p 3000:3000 \
    -p 5000:5000 \
    -u "$(id -u):$(id -g)" \
    --net host \
    -v $WORK_DIR:/home/coder/project \
    -v $HOME/.ssh/:/home/coder/.ssh \
    -v $HOME/.bashrc:/home/coder/.bashrc \
    -v $HOME/.bash_history:/home/coder/.bash_history \
    -v $HOME/.jenkins/:/home/coder/.jenkins \
    -v $HOME/bin/:/home/coder/bin \
    -v $HOME/.gitconfig/:/home/coder/.gitconfig \
    -v $HOME/.boto/:/home/coder/.boto \
    -v $HOME/.kube/:/home/coder/.kube \
    -v $HOME/.config/gcloud/:/home/coder/.config/gcloud/ \
    -v $HOME/.vim/:/home/coder/.vim \
    -v $HOME/.vimrc/:/home/coder/.vimrc \
    -v $HOME/.config/Code:/home/coder/Code \
    -v $HOME/.config/code-server:/home/developer/.config/code-server \
    -v $HOME/.vscode/.config/code-server:/home/coder/.config/code-server \
    -v $HOME/.vscode/extensions:/home/coder/.vscode/extensions \
    -v $HOME/mydomain.com:/home/coder/cert \
    -e PASSWORD=MY_PASS \
    -e SUDO_PASSWORD=MY_PASS \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    vscode-server \
    --cert /home/coder/cert/cert1.pem \
    --cert-key /home/coder/cert/privkey1.pem \
    --extensions-dir /home/coder/.vscode/extensions \
    --user-data-dir /home/coder/Code \
    --config /home/coder/config.yaml \
    --auth password \
    --bind-addr 0.0.0.0:8443;
#    poxstone/code-server:latest \
#    vscode-server \
}

ˊˊˊ

## Custom UID
```bash
USER_ID="$(id -u)";
GROUP_ID="$(id -g)";
DOCKERFILE="./Dockerfile_uid";

grep -m1 -n "VS_USER_CODE" ${DOCKERFILE} | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/[0-9]\+/'${USER_ID}'/' ${DOCKERFILE};
grep -m1 -n "VS_GROUP_CODE" ${DOCKERFILE} | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/[0-9]\+/'${GROUP_ID}'/' ${DOCKERFILE};

docker build -t vscode-server -f ${DOCKERFILE} ./;
```

## kubernetes
```bash
kubectl apply -f k8s_vscode_service.yaml -f k8s_vscode_volume.yaml -f k8s_vscode.yaml;
# inmo vscode
source ./vscode_user_install.sh;
addBashrc;
vimConfig;
addNode "v12";
addGradle "gradle-6.5";
addMvn "3.6.3";
addGCloud "295.0.0";
```