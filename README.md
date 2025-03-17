# Home Lab Recon Engine ⚡  
*Automated security reconnaissance running 24/7 on my private homelab*

### Core Philosophy  
**"Sleep While Your Lab Works"**  
- 🌐 Continuous monitoring  
- 🤖 Zero manual intervention  
- 🔄 Self-healing architecture  
- 📡 Real-time alerting  


```text
[Home Server]——[Monitoring]——[Discord]
       └———[Persistence]———[Auto-Reports]
```
## Recon Automation Toolkit 🔍🤖


An advanced, ever-evolving reconnaissance automation framework designed to streamline offensive security workflows. This personal project is my playground for automating recon, and while it currently features a robust **Subdomain Monitoring System**, more components are on the way! 🚀

## Project Structure 🗂️

```
recon-automation/
├── subdomain-monitor/   # Continuous subdomain discovery & monitoring
├── (future components)  # More tools coming soon!
├── README.md            # This documentation
└── .gitignore           # Global exclusion rules
```

## Components 🧩

### 1. Subdomain Monitoring System
- **Path**: `/subdomain-monitor`
- **Purpose**: Automated subdomain discovery and Discord alerting
- **Features**:
  - Continuous monitoring with **Subfinder**
  - CNAME resolution using **DNSx**
  - Instant **Discord notifications** via Notify
  - Hands-free execution with **systemd service & timer**

[➡️ Detailed Subdomain Monitor Documentation](subdomain-monitor/README.md)

## Usage Examples 🚀

### Individual Tool Execution
```bash
cd subdomain-monitor
sudo systemctl start subdomain-monitor.service
```

## Roadmap 🏗️
This is just the beginning! More automation components will be added soon, covering areas like:
- Port scanning & service enumeration
- Vulnerability detection
- Asset discovery & fingerprinting

Stay tuned for updates! 💥

---

If you have ideas, suggestions, or just want to geek out over recon automation, feel free to reach out. Let’s push the boundaries of automation! 🤘

