#!/bin/bash

# Script to find out the current BTC balance of all addresses to/from which you've sent Bitcoin
#
# Pre-requisites
#
# * curl - https://curl.haxx.se/
# * jq   - https://stedolan.github.io/jq/
#
# Usage
#
#   ./balances.sh [transaction data CSV filename]
#
# Expected output
#
# [BTC address] [final balance in satoshis]
# ...

set -euo pipefail

ADDRESS_FILE=$1  # Filename of transaction data CSV file, exported from your bitcoin wallet

main() {
  local readonly unique_address_file=unique_addresses.csv  # Use any name you like, for this

  get_unique_addresses ${ADDRESS_FILE} > ${unique_address_file}

  for addr in $(bare_addresses ${unique_address_file}); do
    echo $addr $(get_balance_for_address ${addr})
  done
}

get_unique_addresses() {
  local readonly tx_csv=$1
  # tx_csv is the filename of an export from your bitcoin wallet software
  grep -v Address ${tx_csv} | cut -d, -f3,4,5 | sort | uniq
}

bare_addresses() {
  local readonly file=$1
  cat ${file} | cut -d, -f3 | sed 's/"//g'
}

get_balance_for_address() {
  local readonly addr=$1
  fetch_json_for_address ${addr} | jq .addresses[0].final_balance
}


fetch_json_for_address() {
  local readonly addr=$1
  curl -s "https://blockchain.info/multiaddr?cors=true&active=${addr}"
}

main
