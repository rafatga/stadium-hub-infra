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
********************** Initiating projects ********************** \n\n"

printf "${LCYAN}
Write the number of each project you want to start, possible choices are:\n\n"

for hub in $hubs_; do
  index=$(echo $hub | sed 's/^hubs_//')
  hub_dirname="hubs_${index}_dirname"
  DIRECTORY=${!hub_dirname}
  echo "${LMAGENTA}    ${index} - ${DIRECTORY}"
done

printf "${GREEN}
Projects numbers (example: 1 2): " && read -r INPUT

SELECTEDPROJECTS=( "$INPUT" )

docker-compose -p ${infra_name} -f ./docker-compose.yml up -d --build

for PROJECT_INDEX in $SELECTEDPROJECTS; do
  hub_dirname_key="hubs_${PROJECT_INDEX}_dirname"
#  echo ${!hub_dirname_key}
  if [ -n ${!hub_dirname_key} ]; then
    echo "    ${PROJECT_INDEX} - ${!hub_dirname_key}"
    #(cd code/project/ && make dev)
#    make -C "./code/${!hub_dirname_key}/" bootup && make -C "./code/${!hub_dirname_key}/" traefik-start
    make -C "./code/${!hub_dirname_key}/" start
  fi
done
