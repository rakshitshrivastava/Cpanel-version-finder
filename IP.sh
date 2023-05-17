#!/bin/bash

# Qualys API credentials
username="YOUR_USERNAME"
password="YOUR_PASSWORD"

# API request to fetch IP addresses from Qualys
response=$(curl -s -u "$username:$password" "https://qualysapi.qualys.eu/msp/assets/ip" | jq -r '.Ips[] | .ip')

# Save the fetched IP addresses to a file
echo "$response" > ip_addresses.txt

# Run Nmap with cPanel version checking script
nmap_output=$(nmap -p 2082,2083 --script cpanel-brute --script-args "cpanel-brute.hosts=$(cat ip_addresses.txt)" -oG -)

# Process the Nmap output to extract the cPanel version and IP address
while IFS= read -r line; do
    if echo "$line" | grep -q "2082/open"; then
        ip=$(echo "$line" | awk '{print $2}')
        version=$(echo "$line" | grep -oP "(?<=Service Info: ).*")

        if [ -n "$version" ]; then
            echo "cPanel version $version found at $ip"
        else
            echo "cPanel version not found at $ip"
        fi
    fi
done <<< "$nmap_output"
