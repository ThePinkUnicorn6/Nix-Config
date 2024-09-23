#!/bin/sh

# Clone repo
nix-shell -p git --command "git clone https://github.com/thepinkunicorn6/nixos-config ~/nix"

# Login to github and upload ssh key
nix-shell -p gh --command "gh auth login -p ssh"

# Switch to config
read -p "Enter flake config name: " hostname
nixos-rebuild switch --flake ~/nix#$hostname
