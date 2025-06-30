{ config, lib, pkgs, ... }:

{
  services.podman.enable = true;
  programs.distrobox = {
    enable = true;
    enableSystemdUnit = true;
    containers = {
      # common-uv = {
      #   image = "ghcr.io/astral-sh/uv:debian";
      #   entry = true;
      #   volume = "/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro";
      #   additional_packages = "git";
      # };
      # qmk = {
      #   clone = "common-uv";
      #   entry = true;
      #   init_hooks = [
      #     "uv tool install qmk"
      #   ];
      # };
      common-arch = {
        image = "archlinux:latest";
        entry = true;
        volume = "/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro";
        additional_packages = "git";
      };
      qmk = {
        clone = "common-arch";
        entry = true;
        aditional_packages = "qmk git python-pip libffi";
        init_hooks = [
          "sudo pacman --needed --noconfirm -S git python-pip libffi"
          "sudo pacman -S --noconfirm qmk"
        ];
      };
    };
  };
}
 
