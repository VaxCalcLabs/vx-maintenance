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
