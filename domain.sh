#!/bin/bash

# Set your Qualys API credentials
API_USERNAME="your_api_username"
API_PASSWORD="your_api_password"

# Define the Qualys API endpoint
API_URL="https://qualysapi.qualys.com/api/2.0/fo/url/"

# Fetch all onboarded URLs from Qualys
response=$(curl -u "$API_USERNAME:$API_PASSWORD" -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "action=list" "$API_URL")

# Extract the domains from the response
domains=$(echo "$response" | grep -oP '<DOMAIN>.*?</DOMAIN>' | sed -e 's/<\/\?DOMAIN>//g')

# Iterate over each domain
while IFS= read -r domain; do
    echo "Scanning domain: $domain"
    # Run Nmap with cPanel version checking script
    nmap_output=$(nmap -p 2082,2083 --script cpanel-brute --script-args "cpanel-brute.hosts=$domain" -oG -)

    # Process the Nmap output to extract the cPanel version and IP address
    if echo "$nmap_output" | grep -q "2082/open"; then
        version=$(echo "$nmap_output" | grep -oP "(?<=Service Info: ).*")
        echo "cPanel version $version found at $domain"
    else
        echo "cPanel version not found at $domain"
    fi
    echo
done <<< "$domains"
