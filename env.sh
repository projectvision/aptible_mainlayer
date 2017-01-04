#!/bin/bash
set -e

# MAKE SURE YOU'VE SET ENVIROMENTS BEFORE DEPLOY
#
# Check if any set
# aptible config --app appname-name
#
# Set one 
# aptible config:add VAR=value --app appname-name
# 
# 
config_path='/usr/local/tomcat/webapps/mainlayer/WEB-INF/classes/mainlayerOverride.properties'

raise() {
  echo -e "Missing $1 env variable see aptible-cli how to set it" 1>&2
  exit 1
}
check_vars() {
  if [[ -z "${SERVER_URL}" ]]; then
    raise "SERVER_URL"
  fi
  if [[ -z "${DATALAYER_URL}" ]]; then
    raise "DATALAYER_URL"
  fi
}

check_vars

# config file path varies check with Dockerfile if needed
# candidate to move into environment variables
# 
echo -e "server.url=$SERVER_URL\ndatalayer.url=$DATALAYER_URL\n" > $config_path
