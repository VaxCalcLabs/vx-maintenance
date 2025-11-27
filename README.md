# Maintenance Server

This repository contains a tiny, standalone maintenance page and setup script.  
It is designed for use on a temporary Ubuntu machine that takes over your public IP during scheduled maintenance windows.

The maintenance server displays a universal message:

> **“We’re performing an important systems update.  
> Services will be back online soon.  
> Please check back in about an hour.”**

This keeps things simple and avoids referencing specific sites or brands.

## Usage

### 1. Clone the repo

On the Ubuntu machine:

```bash
sudo apt update
sudo apt install git -y
git clone https://github.com/VaxCalcLabs/vx-maintenance.git
cd vx-maintenance
```

### 2. Run the setup script

```bash
chmod +x setup.sh
./setup.sh
```

This will:

- Install **nginx**
- Create `/var/www/maintenance`
- Copy the maintenance `index.html`
- Overwrite the default nginx config
- Reload nginx

## 3. Assign the static IP

If this machine will temporarily replace your production server, assign the static IP (e.g., `44.33.222.111`) using Netplan:

```bash
sudo nano /etc/netplan/01-netcfg.yaml
sudo netplan apply
```

Ensure the machine is connected via **ethernet** when doing this.

## Netplan Configuration (Template Included)

This repo includes a safe, placeholder-only file:

```
netplan-template.yaml
```

Before applying, open it and replace:

- `<YOUR_ETH_INTERFACE>` with the name of your wired interface  
  (check with `ip a` — e.g., `eno1`, `enp3s0`, or `eth0`)
- `<YOUR_STATIC_IP>` with the static IP provided by your ISP
- `<YOUR_GATEWAY_IP>` with your ISP’s default gateway

Then copy it into place:

```bash
sudo cp netplan-template.yaml /etc/netplan/01-netcfg.yaml
```

Apply the configuration:

```bash
sudo netplan apply
```

Or test safely:

```bash
sudo netplan try
```

This template prevents exposing any sensitive network details in the public repo while keeping setup fast and straightforward during maintenance windows.

## 4. Switch the WAN to this machine

During maintenance:

1. Disconnect WAN from your router/firewall  
2. Plug WAN directly into the Ubuntu machine  
3. The maintenance page will immediately serve for all domains routed to that IP  

## Files

```
index.html   — static maintenance page
setup.sh     — one-shot installer for nginx + config
README.md    — documentation and instructions
```

## Notes

- No passwords, SSH keys, or secrets required  
- Repo is intentionally public for quick cloning  
- Designed for short maintenance windows (30–90 minutes)
