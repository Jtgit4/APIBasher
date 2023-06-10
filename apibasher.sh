#!/bin/bash

# Function to send HTTP request and print response code
send_request() {
    local endpoint="$1"
    local host="$2"
    local cookie="$3"
    local call_type="$4"
    
    # Send the HTTP request and capture the response headers
    local response_headers=$(curl -s -I -X $call_type "http://$host$endpoint" -H "Host: $host" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.5" -H "Accept-Encoding: gzip, deflate" -H "Connection: close" -H "Referer: http://$host/home/access" -H "Cookie: $cookie" -H "Upgrade-Insecure-Requests: 1")
    
    # Extract the HTTP response code from the response headers
    local response_code=$(echo "$response_headers" | awk 'NR==1 {print $2}')
    
    # Print the API name, call type, and HTTP response code
    echo "${endpoint#*/} - $call_type: Response Code ==> $response_code"
}

# Define the endpoints along with their call types
endpoints=(
    "/api/v1:GET"
    "/api/v1/invite/how/to/generate:GET"
    "/api/v1/invite/generate:POST"
    "/api/v1/invite/verify:POST"
    "/api/v1/user/auth:GET"
    "/api/v1/user/vpn/generate:POST"
    "/api/v1/user/vpn/regenerate:POST"
    "/api/v1/user/vpn/download:GET"
    "/api/v1/user/register:POST"
    "/api/v1/user/login:POST"
    "/api/v1/admin/auth:GET"
    "/api/v1/admin/vpn/generate:POST"
    "/api/v1/admin/settings/update:PUT"
)

# Set the host and cookie
host="2million.htb"
cookie="PHPSESSID=cga2tf1mug2r2lov42q1rlm8qb"

# Iterate over the endpoints and send requests
for endpoint in "${endpoints[@]}"; do
    IFS=':' read -ra endpoint_parts <<< "$endpoint"
    send_request "${endpoint_parts[0]}" "$host" "$cookie" "${endpoint_parts[1]}"
done
