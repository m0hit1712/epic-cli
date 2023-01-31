#!/bin/bash

source ./services/methods/post_call.sh

register() {
    declare -A request_data
    request_data["organization_name"]='string'
    request_data["owner_email"]="user@example.com"
    request_data["org_mail"]="email@example.com"

    url="http://127.0.0.0:8000/auth/oraganization/"

    example "$url" "3" "$request_data" "$request_data"
}



register