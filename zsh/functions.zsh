#!/usr/bin/env bash

function grepp() {
  ps aux | grep $1
}

function mvnrun () {
  echo mvn $@
  eval mvn $@
  echo mvn $@
}

function mcir () {
  echo mvnrun clean install -rf :$@
  eval mvnrun clean install -rf :$@
  echo mvnrun clean install -rf :$@
}

function mexe () {
    eval mvnrun clean package exec:exec -pl $@
}

function switchm2 () {
    M2_GLOBAL=~/.m2/settings-global.xml
    M2_LGI=~/.m2/settings-lgi.xml
    M2_DEFAULT=~/.m2/settings.xml

    if [ -f ${M2_GLOBAL} ]; then
      echo "setting m2 settings to use $M2_GLOBAL"
      mv ${M2_DEFAULT} ${M2_LGI}
      mv ${M2_GLOBAL} ${M2_DEFAULT}

    elif [ -f ${M2_LGI} ]; then
      echo "setting m2 settings to use $M2_LGI"
      mv ${M2_DEFAULT} ${M2_GLOBAL}
      mv ${M2_LGI} ${M2_DEFAULT}
    fi
}

function kssh {
    POD_ID=$1
    CONTAINER_ID=$2
    POD_NAMESPACE="$(k get pods --all-namespaces | grep $POD_ID | awk '{print $1}')"
    if [ -z "$CONTAINER_ID" ]
      then
        kubectl -n $POD_NAMESPACE exec -it $POD_ID -- sh
      else
        echo "starting with container $CONTAINER_ID"
        kubectl -n $POD_NAMESPACE exec -it $POD_ID -c $CONTAINER_ID -- sh
    fi
}

function lctl {
    COMMAND=$1
    PLIST_FILE=$2
    if [ "$COMMAND" = "reload" ] && [ -n "$PLIST_FILE" ]
      then
        echo "reloading ${PLIST_FILE}.."
        launchctl unload ${PLIST_FILE}
        launchctl load ${PLIST_FILE}
      else
        echo "either command not specified or plist file is not defined"
    fi
}

function mkdircd {
    mkdir -p "$*"
    cd "$*"
}

# gr - search recursively with grep
function gr {
    grep -R "$*" .
}

#Docker
function dsh {
    docker run -it -v ~/dotfiles/docker/.bashrc:/root/.bashrc --entrypoint /bin/sh "$1"
}

function dbash {
    docker run -it -v ~/dotfiles/docker/.bashrc:/root/.bashrc --entrypoint /bin/bash "$1"
}

# Runs docker container with defined before entrypoint and then bashes it
function drbash {
    docker run -it -v ~/dotfiles/docker/.bashrc:/root/.bashrc "$1" /bin/bash
}

function dbashl {
    CONTAINER_ID=`docker ps | tail -1 | awk '{print $1}' | xargs`
    docker exec -it -v ~/dotfiles/docker/.bashrc:/root/.bashrc ${CONTAINER_ID} /bin/bash
}

#Git
# does rebase onto branch if specified otherwise master is used
function grb {
    BRANCH=${1:-master}
    g rb = -x !git checkout $BRANCH && git fetch origin -p && git pull -r && git checkout - && git rebase $BRANCH
}

# Displays who is listen on specified port
function check {
    PORT=${1}
    if [ -z "$PORT" ]
      then
        echo "Port argument is required"
      else
        lsof -i :${PORT} | grep LISTEN
    fi
}

# Password generator
gpwd() {
    pwgen -Bs $1 1 |pbcopy |pbpaste; echo "Has been copied to clipboard"
}

# Telnet
function t() {
  telnet $1 $2
}

function t80() {
  telnet $1 80
}

# Google auth
totp() {
  oathtool --totp -b $(<~/".totp_${1:-google}") | pbcopy;
}