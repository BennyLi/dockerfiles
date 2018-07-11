#!/usr/bin/env sh
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"


OUTPUT_DOCKER_FILE="${1%_tpl}"
echo "Parsing '$1'"
echo "Output file is '$OUTPUT_DOCKER_FILE'"


function parse_file() {
  MAIN_DOCKER_FILE="$1"
  # find includes with lines in file
  while read line; do
    include="$(echo "$line" | grep ^INCLUDE | cut -d '"' -f 2)"
    if [ ! -z "$include" ]; then
      echo "Found INCLUDE statement: '$include'"
      # parse include file
      parse_file "$SCRIPTPATH/includes/$include.Dockerfile"

    else
      echo "$line" >> "$OUTPUT_DOCKER_FILE"
    fi
  done <$MAIN_DOCKER_FILE
}

echo "# Generated Dockerfile! Do not edit!" > "$OUTPUT_DOCKER_FILE"
echo "# Source $1" >> "$OUTPUT_DOCKER_FILE"

parse_file "$1"
