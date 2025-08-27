#!/bin/bash

# Your cloudflare information
API_TOKEN="Your api tokken"
ZONE_ID="Your zone id"
RECORD_ID="Your record id"
DOMAIN="It can also be subdomain ofc"

# A simple txt file that will store your last ip so its no needed for cloudflare api to get triggered for no reason if your ip hasnt changed
IP_FILE="/home/astr4x/last_ip.txt"  # (thats an example, please change the path to where u want to save the "last_ip" file

# Grabbing your current ip
IP=$(curl -s http://checkip.amazonaws.com)

# If cant find ip, exit
if [[ -z "$IP" ]]; then
  echo "Can't find ip!"
  exit 1
fi

# If there is ip but it didnt changed, stop
if [[ -f "$IP_FILE" ]]; then
  LAST_IP=$(cat "$IP_FILE")
  if [[ "$IP" == "$LAST_IP" ]]; then
    echo "Ip didnt changed ($IP), no need for update!"
    exit 0
  fi
fi

# Updating cloudflare, DO NOT change "$ZONE_ID" here cause we put the variables in the start
RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID"
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$DOMAIN\",\"content\":\"$IP\",\"ttl\":1,\"proxied\":false}")

# If new ip updated sucessfully, save it to the "last_ip" file
if echo "$RESPONSE" | grep -q "\"success\":true"; then
  echo "$IP" > "$IP_FILE"
  echo "The ip $IP updated on the domain $DOMAIN in cloudflare succesfully"
else
  echo "Can't update!. Response: $RESPONSE"
fi
