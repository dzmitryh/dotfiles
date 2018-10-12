#!/usr/bin/env bash

function grepp() {
  ps aux | grep $1
}

function mvnrun () {
  echo mvn $@
  eval mvn $@
  echo mvn $@
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
        kubectl -n $POD_NAMESPACE exec -it $POD_ID -- bash
      else
        echo "starting with container $CONTAINER_ID"
        kubectl -n $POD_NAMESPACE exec -it $POD_ID -c $CONTAINER_ID -- bash
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
    docker exec -it "$1" /bin/sh
}

function dbash {
    docker exec -it "$1" /bin/bash
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