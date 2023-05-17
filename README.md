# Cpanel-version-finder
The script automates Qualys data retrieval, detects cPanel versions, and assesses vulnerabilities efficiently.


# cPanel Version Checker

This script is designed to fetch IP addresses from the Qualys API and use Nmap to check the cPanel version on those IP addresses. It can help you identify the cPanel versions present in your network.

## Prerequisites

- `bash` shell
- `curl` command-line tool
- `jq` JSON processor
- `nmap` network scanning tool

## Setup

1. Clone the repository or download the script file.

2. Provide your Qualys API credentials by replacing `YOUR_USERNAME` and `YOUR_PASSWORD` with your Qualys username and password in the script.

3. Make the script executable by running the following command:

   ```bash
   chmod +x ip.sh domain.sh
Run the script:

bash
Copy code
./cpanel_version_checker.sh
The script will fetch the IP addresses from the Qualys API, save them to a file called ip_addresses.txt, and then use Nmap to check the cPanel version on ports 2082 and 2083 for each IP address.

The output will display the cPanel version along with the IP address if a version is found. If the version is not found, it will indicate that in the output.
