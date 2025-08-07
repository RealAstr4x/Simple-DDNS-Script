# Simple-DDNS-Script
A simple ddns script i made for cloudflare, thats helpful a lot when u dont have a static ip.

On the script itself there are instructions.

If you are here for a simple tutorial to get your A record id, here you go mate.

curl -s -X GET "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/dns_records?type=A" \
  -H "Authorization: Bearer YOUR_API_TOKKEN" \
  -H "Content-Type: application/json" | jq -r '.result[] | "\(.name) => \(.id)"'

It should give output in your bash like this

text.lol => (Zone Id) 
aaa.text.lol => (Zone Id) 
bbb.text.lol => (Zone Id)

Any other questions? Add me on discord, "the_real_astr4x"!
