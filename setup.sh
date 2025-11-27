#!/usr/bin/env bash
set -e

echo "Installing nginx..."
sudo apt update
sudo apt install nginx -y

echo "Configuring nginx..."
sudo mkdir -p /var/www/maintenance
sudo cp index.html /var/www/maintenance/index.html

sudo bash -c 'cat >/etc/nginx/sites-enabled/default' <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/maintenance;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

echo "Reloading nginx..."
sudo systemctl reload nginx

echo "Maintenance server ready."
