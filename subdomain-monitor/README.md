# Subdomain Monitoring System 🔍

*A 24/7 automated subdomain monitor running on my home lab server*

## Key Features


- **🕵️ Continuous Discovery**: Scans for new subdomains every 6 hours
- 🚀 **Boot & Forget**: Auto-starts with server reboot via systemd
- 🔔 **Instant Alerts**: Sends Discord notifications for new findings
- &#x20;**🩹 Self-Healing**: Automatic service recovery on failures
-  📦 Self-Contained: Single script with minimal dependencies

```text
Asleep? Busy? Your server never stops watching.
```

## Features ✨

- Continuous subdomain discovery using **Subfinder**
- CNAME resolution with **DNSx**
- Discord notifications via **Notify**
- Systemd service/timer for scheduled execution
- Configurable check intervals and resolvers
- Automatic health checks on server reboot
## Prerequisites ⚙️

- Go 1.20+ (for tool installation)
- Basic Linux server administration skills

## Installation 🛠️

```bash
# Install required tools
go install -v \
  github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest \
  github.com/tomnomnom/anew@latest \
  github.com/projectdiscovery/dnsx/cmd/dnsx@latest \
  github.com/projectdiscovery/notify/cmd/notify@latest

# Clone repository
git clone https://github.com/daaaaaaanyyyyy/subdomain-monitor.git
cd subdomain-monitor

# Deploy systemd services
sudo cp systemd/* /etc/systemd/system/
sudo cp scripts/healthcheck.sh /usr/local/bin/
sudo systemctl daemon-reload
sudo systemctl enable --now submonitor.timer
```

## Configuration ⚙️

### Discord Webhook

```bash
cp config/provider-config.yaml.sample ~/.config/notify/provider-config.yaml
vim ~/.config/notify/provider-config.yaml
```

### Target Domain

Edit `scripts/submonitor.sh`:

```bash
DOMAIN="your-target-domain.com"
```

### Resolvers (optional)
Create `/opt/resolvers.txt` with preferred DNS servers.
### Health Check
```bash
# Edit healthcheck script with your webhook
sudo vim /usr/local/bin/healthcheck.sh
```
## Usage 🚀

```bash
# Manual run
sudo systemctl start submonitor.service

# Check status
systemctl status submonitor.service healthcheck.service


# View logs
journalctl -fu submonitor.service
```

## Maintenance 🛠

  -  Logs:`journalctl -fu submonitor.service`

   - Health checks: `journalctl -u healthcheck.service`

  - Update tools: `go install ...@latest`

  -  Verify webhook URL in healthcheck script after updates

   - Backup: `/opt/subdomain_history.log`
