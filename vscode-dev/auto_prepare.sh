#!/bin/bash

declare VSCODER_LOCAL="local/code-server:latest";
declare VSCODER_CUSTOM="poxstone/code-server:latest";
declare VSCODE_FOLDER="./code-server";

# clone
git clone https://github.com/cdr/code-server.git "${VSCODE_FOLDER}";

# modified source "add portait and landscape support"
declare MANIFIEST="./code-server/scripts/webpack.client.config.js";
grep -n "background_color" $MANIFIEST | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/,.*$/, orientation: "any",/' $MANIFIEST;

#docker build -t "${VSCODER_LOCAL}" -f "${VSCODE_FOLDER}/Dockerfile" "${VSCODE_FOLDER}";
# remove vs code
rm -rf "${VSCODE_FOLDER}";

# prepare Dockerfile
declare USER_ID="$(id -u)";
declare GROUP_ID="$(id -g)";
declare DOCKERFILE="./Dockerfile";
declare VSCODER_LOCAL_SCP=`echo "${VSCODER_LOCAL}" | awk '{gsub("/","\\\/",$0);print($0)}'`;

grep -m1 -n "FROM" ${DOCKERFILE} | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/.*/FROM "'${VSCODER_LOCAL_SCP}'"/' ${DOCKERFILE};
grep -m1 -n "VS_USER_CODE" ${DOCKERFILE} | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/[0-9]\+/'${USER_ID}'/' ${DOCKERFILE};
grep -m1 -n "VS_GROUP_CODE" ${DOCKERFILE} | awk -F ':' '{print($1)}' | xargs -I {} sed -i {}'s/[0-9]\+/'${GROUP_ID}'/' ${DOCKERFILE};


docker build -t "${VSCODER_CUSTOM}" -f ./Dockerfile ./;
docker push "${VSCODER_CUSTOM}";

