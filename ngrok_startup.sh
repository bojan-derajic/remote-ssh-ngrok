#!/bin/bash

# Start ngrok
ngrok tcp 22 > /dev/null 2>&1 &

# Wait for ngrok to start (add more sleep time if needed)
sleep 10

# Get ngrok tunnel URL
ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)

# Send ngrok URL to Telegram
BOT_TOKEN="<YOUR_BOT_TOKEN>"
CHAT_ID="<TARGET_CHAT_ID>"

curl -s -X POST \
  https://api.telegram.org/bot$BOT_TOKEN/sendMessage \
  -d chat_id=$CHAT_ID \
  -d text="ngrok URL: $ngrok_url"
