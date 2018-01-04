#!/bin/bash

set -eu

function task_sign_csr {
  if [[ ! -f 'signme.csr' ]];
  then
    echo "Please download and safe the CSR as: signme.csr"
    exit 1
  fi

  ./dehydrated/dehydrated \
    --register \
    --accept-terms

  ./dehydrated/dehydrated \
    --signcsr ./signme.csr \
    --challenge dns-01 \
    --hook hooks/manual.sh \
    --full-chain \
    > chain.pem
}

function task_upload_chain {
  curl \
    -v \
    --user "$(pass show conversation.im/login):$(pass show conversation.im/pass)" \
    --upload chain.pem \
    https://account.conversations.im/api/domain/certificate
}

function task_usage {
  echo "usage: $0 sign_csr | upload_chain"
  exit 1
}

cmd="${1:-}"
shift || true
case "$cmd" in
  sign_csr) task_sign_csr ;;
  upload_chain) task_upload_chain ;;
  *) task_usage ;;
esac
