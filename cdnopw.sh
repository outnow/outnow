#!/bin/bash

# Your Cloudflare zone ID
ZONE_ID="2d6cd148188eba7f5e3f7c991475bfcf"
# Your Cloudflare DNS record name
RECORD_NAME="test"
# The API key from your Cloudflare account
API_KEY="b07c89e14ccb120eb8acb807ce929c8a4311c"
# Your email associated with Cloudflare account
EMAIL="homles698698@gmail.com"
# The domain you want to update
DOMAIN="mac2win.top"

# Get the record ID using the record name
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$RECORD_NAME" \
     -H "X-Auth-Email: $EMAIL" \
     -H "X-Auth-Key: $API_KEY" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

# Fetch the current public IP address
IP=$(curl -s http://ipv4.icanhazip.com)

# Update DNS record:
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "X-Auth-Email: $EMAIL" \
     -H "X-Auth-Key: $API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'"$DOMAIN"'","content":"'"$IP"'","ttl":1,"proxied":false}'
