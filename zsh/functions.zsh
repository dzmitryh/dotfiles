#!/usr/bin/env bash

function grepp() {
  ps aux | grep $1
}

function mvnrun () {
  echo mvn $@
  eval mvn $@
  echo mvn $@
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
    docker run -it "$1" /bin/sh
}

function dbash {
    docker run -it "$1" /bin/bash
}

#Git
# does rebase onto branch if specified otherwise master is used
function grb {
    BRANCH=${1:-master}
    g rb = -x !git checkout $BRANCH && git fetch origin -p && git pull -r && git checkout - && git rebase $BRANCH
}