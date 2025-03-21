{ config, lib, pkgs, settings, ... }:
let
  homarrData = "${settings.dataDir}/homarr";
  directories = [
    "${homarrData}/configs"
    "${homarrData}/icons"
    "${homarrData}/data"
  ];
in{
  imports = [ ../../nix/services/podman ];

  systemd.tmpfiles.rules = map (x: "d ${x} 0775 ${settings.username} - - -") directories;
  virtualisation.oci-containers.containers."homarr" = {
    image = "ghcr.io/ajnart/homarr:latest";
    volumes = [
      "${homarrData}/configs:/app/data/configs"
      "${homarrData}/icons:/app/public/icons"
      "${homarrData}/data:/data"
    ];
    ports = [
      "7575:7575"
    ];
  };

  services.caddy = {
    virtualHosts."http://home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:7575
    '';
  };
}
