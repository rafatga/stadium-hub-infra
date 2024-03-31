#!/usr/bin/env bash

. ./ops/scripts/yaml-parser.sh --source-only
. ./ops/scripts/variable-colors.sh --source-only

# parse hubs
eval $(parse_yaml config/network.yaml)

printf "${PURPLE}
********************** Global Network ********************** \n\n"

docker network inspect ${network_global_name} >/dev/null 2>&1 || \
    docker network create ${network_global_name} --driver bridge