#!/bin/sh

cd ~;

function addCodeConfig {
  mkdir -p ~/.local/share/code-server/User;
  cat <<EOF > ~/.local/share/code-server/User/settings.json
{
    "breadcrumbs.enabled": false,
    "debug.console.fontSize": 10,
    "debug.internalConsoleOptions": "neverOpen",
    "debug.node.autoAttach": "off",
    "debug.openDebug": "neverOpen",
    "editor.fontSize": 10,
    "editor.minimap.enabled": false,
    "editor.minimap.maxColumn": 80,
    "editor.renderControlCharacters": true,
    "editor.renderWhitespace": "all",
    "editor.rulers": [80,120],
    "editor.suggestSelection": "first",
    "explorer.confirmDelete": false,
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 60000,
    "git.ignoreLegacyWarning": true,
    "keyboard.dispatch": "keyCode",
    "markdown.preview.fontSize": 10,
    "python.jediEnabled": false,
    "terminal.integrated.fontSize": 11,
    "terminal.integrated.rendererType": "dom",
    "workbench.colorCustomizations": {},
    "workbench.colorTheme": "Material Theme High Contrast",
    "workbench.iconTheme": "material-icon-theme",
    "workbench.startupEditor": "newUntitledFile",
    "workbench.statusBar.visible": true,
    "files.watcherExclude": {
        "**/bin/**": true,
        "**/lib/**": true,
        "**/virtual_env/**": true
    },
    "explorer.confirmDragAndDrop": false,
    "python.dataScience.askForKernelRestart": false,
}
EOF

cat <<EOF > ~/.local/share/code-server/User/keybindings.json
// Place your key bindings in this file to override the defaultsauto[]
[
    {
        "key": "ctrl+shift+alt+5",
        "command": "workbench.action.terminal.new"
    },
    {
        "key": "ctrl+shift+c",
        "command": "-workbench.action.terminal.new"
    }
]
EOF
}

function addBashrc {
  touch .bashrc;
  cat <<EOF > ~/.bashrc
case \$- in
  *i*) ;;
    *) return;;
esac

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "\$(SHELL=/bin/sh lesspipe)"

if [ -z "\${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=\$(cat /etc/debian_chroot)
fi

case "\$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "\$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "\$color_prompt" = yes ]; then
  PS1='\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\${PWD##*/}\\[\\033[00m\\]\\\$ '
else
  PS1='\${debian_chroot:+(\$debian_chroot)}\\u@\\h:\\w\\\$ '
fi
unset color_prompt force_color_prompt

if [ -x /usr/bin/dircolors ]; then
  test -r \${HOME}/.dircolors && eval "\$(dircolors -b \${HOME}/.dircolors)" || eval "\$(dircolors -b)"
  alias ls="ls --color=auto";

  alias grep="grep --color=auto"
  alias fgrep="fgrep --color=auto"
  alias egrep="egrep --color=auto"
fi


alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

if [ -f \${HOME}/.bash_aliases ]; then
  . \${HOME}/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

EOF
}

# vim
function vimConfig {
  mkdir -p ~/.vim/autoload;
  mkdir -p ~/.vim/bundle;
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;
  cd ~/.vim/bundle/;
  for i in https://github.com/mattn/emmet-vim \
    https://github.com/scrooloose/nerdtree.git \
    https://github.com/tomtom/tlib_vim \
    https://github.com/leafgarland/typescript-vim \
    https://github.com/MarcWeber/vim-addon-mw-utils \
    https://github.com/vim-scripts/vim-auto-save \
    https://github.com/digitaltoad/vim-pug \
    https://github.com/tpope/vim-sensible \
    https://github.com/wavded/vim-stylus.git; \
  do git clone $i;done;
  cd ~;
  if [ ! -e ~/.vimrc ];then
    touch ~/.vimrc;
    chmod 775 ~/.vimrc;
  fi;
  cat <<EOF > ~/.vimrc
set enc=utf-8
set fileencoding=utf-8set hls
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set wrap!
xnoremap p pgvy
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmet rela  de<CR>
let mapleader = ","
nmap <leader>ne :NERDTreeToggle<cr>
execute pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
EOF
}

# nvm
function addNode {
  local node_version="$1";
  apt-get remove nodejs -y;
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash && \
  . ~/.nvm/nvm.sh && . ~/.bashrc; \
  nvm install "${node_version}" && nvm use "${node_version}" && nvm alias default $(nvm current) && \
  npm i -g stylus nib pug-cli less less-prefixer watch-less http-server bower;
}

#gradle java
function addGradle {
  local gradle_version="$1";
  mkdir -p "${HOME}/bin/gradle/";
  wget "https://services.gradle.org/distributions/${gradle_version}-bin.zip";
  unzip ${gradle_version}-bin.zip;
  mv -f "${gradle_version}" "${HOME}/bin/gradle/";
  rm -r "${gradle_version}-bin.zip";
  cat <<EOF >> ~/.bashrc

export PATH=$PATH:"\${HOME}/bin/gradle/${gradle_version}/bin";
export GRADLE_HOME="\${HOME}/bin/gradle/${gradle_version}/";
EOF
}

# mvn
function addMvn {
  local maven_version="${1}";
  mkdir -p "${HOME}/bin/maven/";
  wget "https://downloads.apache.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz";
  tar -xzf apache-maven-${maven_version}-bin.tar.gz;
  mv -f "./apache-maven-${maven_version}" "${HOME}/bin/maven/";
  rm -f "apache-maven-${maven_version}-bin.tar.gz";
  cat <<EOF >> ~/.bashrc

export PATH=$PATH:"\${HOME}/bin/apache-maven-${maven_version}/bin/";
export MVN_HOME="\${HOME}/bin/apache-maven-${maven_version}";
EOF
}

# install gcloud
function addGCloud {
  local gcloud_version="${1}";
  curl -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${gcloud_version}-linux-x86_64.tar.gz";
  tar -zxf "google-cloud-sdk-${gcloud_version}-linux-x86_64.tar.gz";
  mv "./google-cloud-sdk" "${HOME}/bin/";
  # replace installer line folder fix
  sed -i 's#$(_cloudsdk_root_dir "$0")#~/bin/google-cloud-sdk#g' "${HOME}/bin/google-cloud-sdk/install.sh";
  # installation required one parameter
  . "${HOME}/bin/google-cloud-sdk/install.sh" --override-components;
  rm -f "google-cloud-sdk-${gcloud_version}-linux-x86_64.tar.gz";
  source ~/.bashrc;
  gcloud components install \
    alpha beta \
    app-engine-go \
    app-engine-python app-engine-python-extras \
    bq \
    bigtable \
    cbt \
    cloud-build-local \
    datalab \
    docker-credential-gcr \
    kubectl -q;
}

#addCodeConfig
#addBashrc;
#vimConfig;
#addNode "v12";
#addGradle "gradle-6.5";
#addMvn "3.6.3";
#addGCloud "295.0.0";
