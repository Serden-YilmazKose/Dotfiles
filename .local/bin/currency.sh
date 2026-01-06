#!/bin/sh

# Make API request and use jq to parse results
results=$(curl --silent "https://currencyrateapi.com/api/latest?codes=USD&base_currency=EUR")
dollar=$(echo "$results" | jq '.result.USD')
[ -n "$dollar" ] && echo "$dollar"
