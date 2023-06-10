#!/bin/bash

# Function to send HTTP request and print response code
send_request() {
    local endpoint="$1"
    local host="$2"
    local cookie="$3"
    
    # Send the HTTP request and capture the response headers
    local response_headers=$(curl -s -I -X GET "http://$host$endpoint" -H "Host: $host" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.5" -H "Accept-Encoding: gzip, deflate" -H "Connection: close" -H "Referer: http://$host/home/access" -H "Cookie: $cookie" -H "Upgrade-Insecure-Requests: 1")
    
    # Extract the HTTP response code from the response headers
    local response_code=$(echo "$response_headers" | awk 'NR==1 {print $2}')
    
    # Print the API name, call type, and HTTP response code
    echo "${endpoint#*/} - GET: Response Code ==> $response_code"
}

# Define the endpoints
endpoints=(
    "/api/v1"
    "/api/v1/invite/how/to/generate"
    "/api/v1/invite/generate"
    "/api/v1/invite/verify"
    "/api/v1/user/auth"
    "/api/v1/user/vpn/generate"
    "/api/v1/user/vpn/regenerate"
    "/api/v1/user/vpn/download"
    "/api/v1/user/register"
    "/api/v1/user/login"
    "/api/v1/admin/auth"
    "/api/v1/admin/vpn/generate"
    "/api/v1/admin/settings/update"
)

# Set the host and cookie
host="2million.htb"
cookie="PHPSESSID=cga2tf1mug2r2lov42q1rlm8qb"

# Iterate over the endpoints and send requests
for endpoint in "${endpoints[@]}"; do
    send_request "$endpoint" "$host" "$cookie"
done
