#!/bin/bash

set -eu

# based on https://github.com/lukas2511/dehydrated/wiki/example-dns-01-nsupdate-script

function task_deploy_challenge {
  echo ""
  echo "Add the following to the zone definition of ${1}:"
  echo "_acme-challenge.${1}. IN TXT \"${3}\""
  echo ""
  echo -n "Press enter to continue..."
  read tmp
  echo ""
}

function task_clean_challenge {
  echo ""
  echo "Now you can remove the following from the zone definition of ${1}:"
  echo "_acme-challenge.${1}. IN TXT \"${3}\""
  echo ""
  echo -n "Press enter to continue..."
  read tmp
  echo ""
}

function task_invalid_cert {
  echo ""
  echo "$@"
  echo "A cert challenge is invalid"
}


function task_usage {
  echo "usage: $0 .."
  exit 1
}

cmd="${1:-}"
shift || true
case "$cmd" in
  deploy_challenge) task_deploy_challenge "$@" ;;
  clean_challenge) task_clean_challenge "$@" ;;
  invalid_cert) task_invalid_cert "$@" ;;
  deploy_cert) ;;
  unchanged_cert) ;;
  *) task_usage ;;
esac
