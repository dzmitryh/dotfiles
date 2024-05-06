#!/usr/bin/env bash
set +x

function grepp() {
  ps aux | grep $1
}

function mvnrun () {
  echo mvn $@ -T 1C
  eval mvn $@ -T 1C
  echo mvn $@ -T 1C
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
    PRJ_POSTFIX=$1
    M2_TARGET=~/.m2/settings-${PRJ_POSTFIX}.xml
    M2_DEFAULT=~/.m2/settings.xml

    if [ -f ${M2_TARGET} ]; then
      echo "setting m2 settings to use $M2_TARGET"
      M2_PREV="$(findPrevPrj)"
      echo "prev settings = "${M2_PREV}
      mv ${M2_DEFAULT} ${M2_PREV}
      mv ${M2_TARGET} ${M2_DEFAULT}
    else
      echo "already using ${M2_TARGET}"
    fi
}

function findPrevPrj() {
  M2_RR=~/.m2/settings-rr.xml
  M2_MED=~/.m2/settings-med.xml
  M2_GLOBAL=~/.m2/settings-global.xml
  M2_ANOTHER=~/.m2/settings-another.xml

  if [ ! -f ${M2_MED} ]; then
    echo ${M2_MED}
  elif [ ! -f ${M2_RR} ]; then
    echo ${M2_RR}
  elif [ ! -f ${M2_GLOBAL} ]; then
    echo ${M2_GLOBAL}
  elif [ ! -f ${M2_ANOTHER} ]; then
    echo ${M2_ANOTHER}
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

# Logs
function tl() {
  tail -f $1
}

# Google auth
totp() {
  oathtool --totp -b $(<~/".totp_${1:-google}") | pbcopy;
}

# Encoding & Decoding
function b64e() {
    echo -n $1 | base64
}

function b64d() {
    echo $1 | base64 --decode
}

function sha1() {
    echo -n $1 | openssl sha1
}

# Intelij Idea
function reloadIdea() {
  # enable tracing
  set +x
  # reloads zsh
  zr
  # find idea process and kills it
  kill $(ps aux | grep 'idea' | awk 'NR==1{print $2}')
  sleep 10
  # starting new idea instance
  # idea
}