#!/bin/bash
# ARMUX Recon Tool by Ayush

banner() {
  clear
  echo -e "\e[92m"
  echo "  █████╗ ██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗"
  echo " ██╔══██╗██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝"
  echo " ███████║██████╔╝██╔████╔██║██║   ██║ ╚███╔╝ "
  echo " ██╔══██║██╔═══╝ ██║╚██╔╝██║██║   ██║ ██╔██╗ "
  echo " ██║  ██║██║     ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗"
  echo " ╚═╝  ╚═╝╚═╝     ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝"
  echo -e "\e[93m           Coded by Ayush (ARMUX SS)"
  echo -e "\e[0m"
}

menu() {
  echo -e "\e[91m[1]\e[0m Whois Lookup"
  echo -e "\e[91m[2]\e[0m IP Info"
  echo -e "\e[91m[3]\e[0m Subdomain Finder (using crt.sh)"
  echo -e "\e[91m[4]\e[0m Port Scanner (basic)"
  echo -e "\e[91m[5]\e[0m Exit"
}

whois_lookup() {
  read -p "Enter domain: " domain
  whois $domain | tee whois_$domain.txt
}

ip_info() {
  read -p "Enter IP: " ip
  curl -s ipinfo.io/$ip | tee ipinfo_$ip.txt
}

subdomain_finder() {
  read -p "Enter domain: " domain
  curl -s "https://crt.sh/?q=%25.$domain&output=json" | grep -oE '"name_value":"[^"]+"' | cut -d':' -f2 | tr -d '"' | sort -u | tee subdomains_$domain.txt
}

port_scan() {
  read -p "Enter IP/domain: " target
  for port in 21 22 23 25 53 80 110 139 143 443 445 8080; do
    (echo >/dev/tcp/$target/$port) &>/dev/null && echo "Port $port is open"
  done | tee ports_$target.txt
}

# Main loop
while true; do
  banner
  menu
  echo ""
  read -p "Choose option: " opt
  case $opt in
    1) whois_lookup ;;
    2) ip_info ;;
    3) subdomain_finder ;;
    4) port_scan ;;
    5) echo "Exiting..."; break ;;
    *) echo "Invalid choice!"; sleep 1 ;;
  esac
  echo -e "\nPress Enter to continue..."
  read
done
