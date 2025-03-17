#!/bin/bash
set -euo pipefail

# Configuration
DOMAIN="your-target-domain.com"
SUBDOMAINS_FILE="/opt/subdomains.txt"
HISTORY_FILE="/opt/subdomain_history.log"
RESOLVERS_FILE="/opt/resolvers.txt"
NOTIFY_CONFIG="~/.config/notify/provider-config.yaml"
DISCORD_ID="subdomain-bot"


NEW_SUBS=$(mktemp)
CNAME_RESULTS=$(mktemp)

~/go/bin/subfinder -d "$DOMAIN" -silent -all | \
~/go/bin/anew "$SUBDOMAINS_FILE" > "$NEW_SUBS"

if [[ -s "$NEW_SUBS" ]]; then
    
    echo "[DEBUG] New subdomains found:" >&2
    cat "$NEW_SUBS" >&2

    ~/go/bin/dnsx -silent -cname -retry 2 -r "$RESOLVERS_FILE" -l "$NEW_SUBS" -o "$CNAME_RESULTS"

    
    echo "[DEBUG] DNSx CNAME results:" >&2
    cat "$CNAME_RESULTS" >&2

    if [[ -s "$CNAME_RESULTS" ]]; then

        echo "[DEBUG] Preparing Discord notification..." >&2
        {
            echo "**New Subdomains for \`$DOMAIN\`**"
            echo "\`\`\`diff"
            awk '{printf "+ %-40s → %s\n", $1, $2}' "$CNAME_RESULTS"
            echo "\`\`\`"
            echo "_Scan completed: $(date +'%Y-%m-%d %H:%M %Z')_"
        } | ~/go/bin/notify -provider-config "$NOTIFY_CONFIG" -p discord -id "$DISCORD_ID" -bulk -silent
    else
        
        echo "[ERROR] DNSx returned empty CNAME results" >&2
    fi

    awk '{print $1}' "$CNAME_RESULTS" >> "$HISTORY_FILE"
else
    
    echo "[DEBUG] No new subdomains detected" >&2
fi

rm -f "$NEW_SUBS" "$CNAME_RESULTS"
