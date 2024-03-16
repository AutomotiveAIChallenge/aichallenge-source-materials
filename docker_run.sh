#!/bin/bash

target=${1}
device=${2}

case "${target}" in
"eval")
    volume="output:/output"
    ;;
"dev")
    volume="aichallenge:/aichallenge"
    ;;
*)
    echo "invalid argument (use 'dev' or 'eval')"
    exit 1
    ;;
esac

case "${device}" in
"cpu")
    opts="--device /dev/dri"
    ;;
"gpu")
    opts="--nvidia"
    ;;
*)
    echo "invalid argument (use 'gpu' or 'cpu')"
    exit 1
    ;;
esac

mkdir -p output

# shellcheck disable=SC2086
rocker ${opts} --x11 --user --net host --privileged --volume "${volume}" -- "aichallenge-source-materials-${target}"
