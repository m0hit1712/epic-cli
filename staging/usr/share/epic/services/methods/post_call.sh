example() {
    local url="$1"
    local len="$2"
    shift 2
    local data=("${@:1:$len}")

    for key in "${data[@]}"; do
    echo "$key"
    done

    
    
    echo -e "\n\n $url $len"

# curl -X 'POST' \
#   'http://127.0.0.0:8000/auth/oraganization/' \
#   -H 'accept: application/json' \
#   -H 'Content-Type: application/json' \
#   -d '{
#   "organization_name": "string",
#   "owner_email": "user@example.com",
#   "org_mail": "user@example.com"
# }'
}