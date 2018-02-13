#!/usr/bin/env bash

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# OSX general
alias ls="ls -FHG"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lls='ls -all'
alias cb='pbcopy' 

# Vim
alias v="vim"

# Always edit crontab with Vim
alias crontab="VIM_CRONTAB=true crontab"

# Git 
alias g='git'
alias gs='git status'
alias ga='git add .'
alias gl='git pull'
alias gp='git push'
alias gc='git commit'
alias gd='git diff'
alias git commit='git commit -S'

# Maven
alias mci='mvnrun clean install'
alias mcd='mvnrun clean deploy'
alias mct='mvnrun clean test'

# K8s
alias k='kubectl'
alias kbusybox='k --namespace=default exec -it `k get pods --namespace=default | grep busybox | cut -d " " -f 1` sh'
alias kclusterdev='k config set current-context dev'
alias kclusterobo='k config set current-context obo'
alias kdev='k -n development'
alias klab5a='k -n lab5a'

# Docker
alias di='docker images'
alias dps='docker ps -a'
alias db='docker build'
alias drmi='docker rmi'
alias drm='docker rm'
alias dr='docker run'
alias ds='docker stop'
alias dins='docker inspect'