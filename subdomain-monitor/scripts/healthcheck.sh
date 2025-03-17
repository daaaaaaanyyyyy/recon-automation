#!/bin/bash

# Discord webhook URL (replace with your actual URL)
WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN"

send_discord_alert() {
    local message="$1"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"$message\"}" "$WEBHOOK_URL"
}

# Check service status
if ! systemctl is-active --quiet submonitor.service; then
    send_discord_alert "🔴 CRITICAL: submonitor.service is DOWN! Attempting restart..."
    
    # Try to restart
    if systemctl restart submonitor.service; then
        send_discord_alert "🟢 Restart succeeded! Service is now ACTIVE"
    else
        send_discord_alert "🔥 DOUBLE FAILURE: Restart attempt failed! Manual intervention required"
        exit 1
    fi
fi

# Check last scan time (optional)
LAST_SCAN=$(stat -c %Y /opt/subdomain_history.log 2>/dev/null || echo 0)
NOW=$(date +%s)
DIFF=$(( (NOW - LAST_SCAN) / 60 ))

if [ $DIFF -gt 360 ]; then  # 6 hour threshold
    send_discord_alert "⚠️ WARNING: No new scans in ${DIFF} minutes"
fi

# Send boot confirmation
send_discord_alert "🏠 Server boot detected - Monitoring system OPERATIONAL"