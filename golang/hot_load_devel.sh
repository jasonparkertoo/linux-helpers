#!/bin/sh

AIR_CMD=`which air`
test ${?} = "0" || {
    echo "air command not found, exiting..."
    exit 1
}

test -d "${HOME}/.builds" | mkdir -p ${HOME}/.builds

TEMP_DIR=$(mktemp -d ~/.builds/build-XXXXX)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


#
# cleanup after ctrl-c
#
handleCtrlC() {
    echo "removing build directory: ${TEMP_DIR}"
    rm -rf ${TEMP_DIR}
}
trap handleCtrlC INT

#
# run air
#
air -build.cmd "go build -o ${TEMP_DIR}/out ${SCRIPT_DIR}/../cmd/main.go" -build.bin "${TEMP_DIR}/out" -tmp_dir "${TEMP_DIR}"
