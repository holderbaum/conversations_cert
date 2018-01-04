#!/bin/bash

set -eu

function task_usage {
  echo "$0: .."
  exit 1
}

cmd="${1:-}"
shift || true
case "$cmd" in
  *) task_usage ;;
esac
