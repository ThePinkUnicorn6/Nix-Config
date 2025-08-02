{ config, lib, pkgs, ... }:

{
   # creating network namespace
  systemd.services."netns@" = {
   description = "%I network namespace";
   before = [ "network.target" ];
   serviceConfig = {
     Type = "oneshot";
     RemainAfterExit = true;
     ExecStart = "${pkgs.iproute2}/bin/ip netns add %I";
     ExecStop = "${pkgs.iproute2}/bin/ip netns del %I";
   };
  };
  networking.nftables = {
    enable = true;
    ruleset = ''
      table inet mullvad_tailscale {
        chain output {
          type route hook output priority -100; policy accept;
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }

        chain input {
          type filter hook input priority -100; policy accept;
          ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      }
    '';
  };
  networking.wg-quick.interfaces.wg0.configFile = "/root/wg0.conf";
  systemd.services."wg-quick-wg0" = {
   bindsTo = [ "netns@wg.service" ];
   requires = [ "network-online.target" ];
   after = [ "netns@wg.service" ];
  };
}
