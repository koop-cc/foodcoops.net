#!/bin/sh

set -eu

action="$1"
# the following arguments are only valid for the action "deploy_cert"
domain="${2:-}"
key_path="${3:-}"
cert_path="${4:-}"
fullchain_path="${5:-}"


if [ "$action" = "deploy_cert" ]; then
    case "$domain" in
        *)
            /usr/sbin/nginx -s reload
            ;;
    esac
fi