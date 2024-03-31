#!/usr/bin/env bash

. ./ops/scripts/yaml-parser.sh --source-only
. ./ops/scripts/variable-colors.sh --source-only

#################################################################################
## START OF SCRIPT
#################################################################################

# parse hubs
eval $(parse_yaml config/projects.yaml)
eval $(parse_yaml config/network.yaml)

printf "${PURPLE}
********************** Stopping projects ********************** \n\n"

for hub in $hubs_; do
  index=$(echo $hub | sed 's/^hubs_//')
  hub_dirname="hubs_${index}_dirname"
  DIRECTORY=${!hub_dirname}
  echo "${LMAGENTA}[!] Stopping $DIRECTORY"
  make -C "./code/$DIRECTORY/" stop
done

docker-compose -p ${infra_name} -f docker-compose.yml kill
docker-compose -p ${infra_name} -f docker-compose.yml rm -f