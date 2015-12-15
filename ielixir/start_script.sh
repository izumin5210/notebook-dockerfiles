#!/usr/bin/env bash

if [ ! $# -eq 1 ]
then
  echo "Usage: ./start_script.sh [connection_file]"
  exit 1
fi

if [ -z "$MIX_ENV" ]
then
  export MIX_ENV=prod
fi
IELIXIR_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/
cd $IELIXIR_PATH
CONNECTION_FILE=$1 elixir --erl "-smp enable" /elixir/bin/mix run --no-halt
