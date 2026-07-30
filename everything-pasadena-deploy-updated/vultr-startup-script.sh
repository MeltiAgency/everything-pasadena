#!/bin/bash
# Vultr "Startup Script" for Everything Pasadena static site.
# Paste this into Vultr's Startup Script field when deploying a new server
# (Products > Startup Scripts > Add Script), then select it during server
# creation. Works on Ubuntu 22.04/24.04 images.
#
# IMPORTANT: replace YOUR_GITHUB_USERNAME/YOUR_REPO_NAME below with your
# actual GitHub repo (e.g. tiffanylu/everything-pasadena) before pasting.

apt-get update -y
apt-get install -y nginx git

rm -rf /var/www/html
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git /var/www/html

systemctl enable nginx
systemctl restart nginx
