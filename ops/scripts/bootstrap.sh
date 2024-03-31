#!/usr/bin/env bash

. ./ops/scripts/yaml-parser.sh --source-only
. ./ops/scripts/variable-colors.sh --source-only

# Download git repos
function downloadProjectsFromRepositories() {
  downloaded=1
  folder="code"

  echo "${YELLOW}[...] Checking git repo to download..."
  mkdir -p "$folder"
  for hub in $hubs_; do
      index=$(echo $hub | sed 's/^hubs_//')
      hub_url="hubs_${index}_url"
      hub_dirname="hubs_${index}_dirname"
      hub_branchname="hubs_${index}_branchname"
      echo ${!hub_url}
      echo ${!hub_dirname}
      echo ${!hub_branchname}
      REPO=${!hub_url}
      DIRECTORY=${!hub_dirname}
      if [ ! -d "$folder/${DIRECTORY}" ]; then
        git clone -b ${!hub_branchname} ${!hub_url} "$folder/${DIRECTORY}"
        downloaded=0
      fi
  done

  if [ "$downloaded" = 1 ]; then
    echo "${YELLOW}[...] All repos downloaded, nothing to download..."
  fi
}

function createDockerGlobalNetwork() {
  OUTPUT=$(docker network inspect "${network_global_name}" 2>&1)

  if echo ${OUTPUT} | grep -q "${network_global_name} not found"; then
        echo "${YELLOW}[...] ${network_global_name} doesn't exist"
        docker network create ${network_global_name} --driver bridge
  else
        echo "${YELLOW}[...] ${network_global_name} already exist"
  fi
}

#################################################################################
## START OF SCRIPT
#################################################################################

# parse hubs
eval $(parse_yaml config/projects.yaml)
eval $(parse_yaml config/network.yaml)

#echo $network_global_name

printf "${PURPLE}
********************** bootstrapping ********************** \n\n"

echo "${LCYAN}[!] Starting process of repositories download"
downloadProjectsFromRepositories
echo "${LGREEN}[!] Ended process of repositories download"

echo "${LCYAN}[!] Starting process of creating (${network_global_name})"
createDockerGlobalNetwork
echo "${LGREEN}[!] Ended process of creating (${network_global_name})"




