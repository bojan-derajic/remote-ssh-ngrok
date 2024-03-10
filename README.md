## Description
This repository contains the shell script and instructions for enabeling ssh connection to a remote machine outside of the local network using ngrok. Since the URL address and port number change every time when the ngrok agent is started, the srcipt automatically sends the new URL address and port number to the provided Telegram bot on system startup.

## Instructions

### 1. Setup ngrok
Create [ngrok](https://ngrok.com/) account, install ngork on your machine and add the provided token to it (instructions available on the ngrok website after log in)

### 2. Setup Telegram bot
- Step 1: Create a Telegram Bot
    - Open Telegram and search for the "BotFather" bot.
    - Start a chat with BotFather and use the /newbot command to create a new bot.
    - Follow the instructions to choose a name and username for your bot.
    - Once your bot is created, BotFather will provide you with a token. Save this token for later.

- Step 2: Install `curl` and `jq`
    - Make sure you have the `curl` and `jq` tools installed on your system. You can install them using your system's package manager, for example: `sudo apt-get install curl jq`

- Step 3: Get the Chat ID
    - You need to get the Chat ID of the user or channel where you want to send messages. Use the following API call to get the Chat ID: `curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates" | jq .result[0].message.chat.id`
    - Replace `$BOT_TOKEN` with your actual bot token. Copy the Chat ID for use in your script.

### 3. Setup the startup script
- Copy the `ngrok_startup.sh` script to your home folder
- Inside the script, set the `BOT_TOKEN` and `CHAT_ID` variables to the values you obtained in the previous step
- Make the script executable: `chmod +x ngrok_startup.sh`

### 4. Create systemd service
- Copy the `ngrok.service` file to `/etc/systemd/system/`
- If the ngrok startup script should be executed by a user other than root, then edit the `User` field inside the service file accordingly
- Reload the systemd daemon to load the new service unit file: `sudo systemctl daemon-reload`
- Enable the service to start at boot: `sudo systemctl enable ngrok.service`
- Start the service: `sudo systemctl start ngrok.service`