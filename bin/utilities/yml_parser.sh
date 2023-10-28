#!/bin/bash

parse_yaml() {
  local file="$1"
  local prefix="${2:-}"

  while IFS= read -r line; do
    # Ignore comments and empty lines
    if [[ "$line" =~ ^[[:space:]]*# || -z "$line" ]]; then
      continue
    fi

    local key
    local value
    if [[ "$line" =~ ^[[:space:]]*([^:]+):[[:space:]]*(.*)$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
    else
      echo "Error: Invalid line in YAML file: $line"
      return 1
    fi

    key="${key%"${key##*[![:space:]]}"}"  # Trim trailing whitespace
    key="${key#"${key%%[![:space:]]*}"}"  # Trim leading whitespace
    value="${value%"${value##*[![:space:]]}"}"  # Trim trailing whitespace
    value="${value#"${value%%[![:space:]]*}"}"  # Trim leading whitespace

    if [ -n "$key" ]; then
      echo "${prefix}${key}=$value"
    fi
  done < "$file"
}

# Usage
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <yaml_file>"
  exit 1
fi

parse_yaml "$1"

## ./yml_parser.sh ../../config/conf-files/project-config.yml  >> test.sh
