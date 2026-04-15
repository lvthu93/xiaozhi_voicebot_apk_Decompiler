#!/bin/sh

# ===== INPUT =====
if [ -z "$1" ]; then
    echo "Usage: sh script.sh <mac_address>"
    exit 1
fi

MAC=$(echo "$1" | tr 'A-Z' 'a-z')

# ===== GENERATE UUID =====
if command -v uuidgen >/dev/null 2>&1; then
    UUID=$(uuidgen)
else
    UUID=$(cat /proc/sys/kernel/random/uuid)
fi

echo "MAC: $MAC"
echo "UUID: $UUID"

# ===== REQUEST =====
URL="https://api.tenclass.net/xiaozhi/ota/activate"

RESPONSE=$(wget -qO- \
  --header="Device-Id: $MAC" \
  --header="Client-Id: $UUID" \
  --header="X-Language: Chinese" \
  --header="Content-Type: application/json" \
  --header="User-Agent: okhttp/3.12.1" \
  --post-data="{\"mac_address\":\"$MAC\",\"uuid\":\"$UUID\"}" \
  "$URL")

# ===== OUTPUT =====
echo "Response: $RESPONSE"
