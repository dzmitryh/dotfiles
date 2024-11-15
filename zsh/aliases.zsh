#!/usr/bin/env bash

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# OSX general & other
alias ls="ls -FHG"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lls='ls -all'
alias llst='lls -t'
alias llsl='ls -ltr' # sort by date, most recent last
alias cb='pbcopy'
alias updots='cd ~/dotfiles && g pull && source ~/.zshrc'
alias ccat='pygmentize -g'
alias showals='cat ~/dotfiles/zsh/aliases.zsh'
alias showfs='cat ~/dotfiles/zsh/functions.zsh'
alias size='du -h . -d 1 | sort -h'
alias sizer='du -ah | sort -h'
alias zr='source ~/.zshrc'
alias getsw='~/ebs/get-sw.sh'
alias jb='~/ebs/run-jenkins-build.sh'

# Vim
alias v="vim"

# Always edit crontab with Vim
alias crontab="VIM_CRONTAB=true crontab"

# Git 
alias g='git'
alias gs='git status'
alias ga='git add .'
alias gl='git pull'
alias glr='git pull -r'
alias glm='git pull origin master'
alias gf='git fetch'
alias gst= 'git stash'
alias gstp='git stash pop'
alias gp='git push'
alias gc='git commit'
alias gd='git diff'
alias gbr='git checkout -b'
alias grs='g remote -v'
alias gsbr='g branch --all'
alias gres='git reset --hard origin/master'
alias gt='g fetch -t'
alias grtags='g ls-remote --tags --sort=committerdate origin'
alias gltags='g fetch -t && g ls-remote --tags --sort=committerdate origin'
alias gum='g up master'
alias gud='g up develop'
alias gcl='g clone'
alias uprjs="ls -R -d --color=never */.git | sed 's/\/.git//' | xargs -I{} bash -c 'echo Updating {}..; git -C {} pull'"

# BitBucket
alias bpr='bitbucket-pr'

# Maven
alias mcc='mvnrun clean compile'
alias mcp='mvnrun clean package'
alias mci='mvnrun clean install'
alias mcist='mvnrun clean install -DskipTests=true'
alias mcis='mvnrun clean source:jar install'
alias mcd='mvnrun clean deploy'
alias mct='mvnrun clean test'
alias mcit='mvnrun verify -pl integration-tests -Ptests-for-localhost'
alias mdt='mvnrun dependency:tree'
alias mvu='mvnrun versions:use-latest-versions -DgenerateBackupPoms=false'
alias mvup='mvnrun versions:update-properties validate -DgenerateBackupPoms=false'
alias mvns='cat ~/.m2/settings.xml'

# K8s
alias k='kubectl'
alias kbusybox='k --namespace=default exec -it `k get pods --namespace=default | grep busybox | cut -d " " -f 1` sh'
alias kclusterdev='k config set current-context dev'
alias kclusterobo='k config set current-context obo'
alias kclusterprod='k config set current-context prod'
alias kdev='k -n development'
alias klab5a='k -n lab5a'

# Docker
alias dk='docker'
alias di='docker images'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias db='docker build'
alias drmi='docker rmi'
alias drm='docker rm'
alias dr='docker run'
alias ds='docker stop'
alias dins='docker inspect'
alias dl='docker logs'
alias dsl="dps | awk 'END {print $1}' | xargs docker stop"
alias dcu="docker-compose up -d"

# Sdkman
alias java10='sdk default java 10.0.2-open'
alias java11='sdk default java 11.0.1-open'
alias jv='sdk list java'

# Mysql
alias cmysql='mysql -u root -proot'

# Vagrant
alias vup='vagrant up'
alias vr='vagrant reload'
alias vh='vagrant halt'
alias vs='vagrant ssh'

# Network
alias prt='netstat -nr'

# Podman
# alias podman-sock="rm -f /tmp/podman.sock && ssh -i ~/.ssh/podman-machine-default -p \$(podman system connection list --format=json | jq '.[0].URI' | sed -E 's|.+://.+@.+:([[:digit:]]+)/.+|\1|') -L'/tmp/podman.sock:/run/user/1000/podman/podman.sock' -N core@localhost"