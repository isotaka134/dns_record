# DNS Record Scanner

## Overview
The **DNS Record Scanner** is a Metasploit auxiliary module designed to gather DNS records for a specified domain. This tool allows ethical hackers and penetration testers to retrieve detailed information about a domain's DNS configuration, which can aid in reconnaissance and security assessments.

## Features
- **A Records**: Retrieve all IP addresses associated with the domain.
- **MX Records**: Identify mail exchange servers and their priorities.
- **TXT Records**: Collect text records, including single strings and arrays.
- **NS Records**: Enumerate name servers for the domain.
- Handles DNS resolution errors gracefully and provides meaningful error messages.

## Usage
### Prerequisites
- Metasploit Framework installed on your system.

### Loading the Module
1. Save the script as `dns_record_scanner.rb` in the Metasploit `modules/auxiliary` directory.
2. Start Metasploit Framework:
   ```bash
   msfconsole
   ```
3. Load the module:
   ```bash
   use auxiliary/dns_record_scanner
   ```

### Options
| Option  | Description                         | Required |
|---------|-------------------------------------|----------|
| DOMAIN  | The domain to scan for DNS records | Yes      |

### Example Usage
1. Set the domain to scan:
   ```bash
   set DOMAIN example.com
   ```
2. Run the scanner:
   ```bash
   run
   ```
3. View the results in the console output.

## Sample Output
```
[*] Resolving DNS records for: example.com
[+] A Record (IP Address): 93.184.216.34
[+] MX Record: mail.example.com with priority 10
[+] TXT Record: v=spf1 include:_spf.google.com ~all
[+] NS Record: ns1.example.com
[+] NS Record: ns2.example.com
[*] Finished scanning DNS records for example.com.
```

## Error Handling
- If the domain is not specified:
  ```
  [-] You must specify a domain.
  ```
- If DNS resolution fails:
  ```
  [-] DNS resolution failed: <error message>
  ```
- If any unexpected error occurs:
  ```
  [-] An error occurred: <error message>
  ```

## License
This module is licensed under the MSF License.

## Author
Created by ISOTAKA NOBOMARO.


