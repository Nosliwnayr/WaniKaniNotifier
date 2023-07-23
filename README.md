This script checks if new reviews are ready on WaniKani and sends a push notification via Gotify if there are any.

### Prerequisites:
- A [Gotify](https://gotify.net/) instance
- A [WaniKani API token](https://www.wanikani.com/settings/personal_access_tokens)
- [LuaRocks](https://luarocks.org/)

### Usage:
Install the script via LuaRocks and schedule running the script hourly (I'm using systemd timers to do this)

The script requires 3 arguments:
- Your WaniKani API Token
- A Gotify instance URL
- A Gotify application token

Usage example: `lua notifier.lua <WaniKani API Token> <Gotify URL> <Gotify Application Token>`