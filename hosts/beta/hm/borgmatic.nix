{ config, lib, pkgs, settings, ... }:

{
  programs.borgmatic = {
    enable = true;
    backups = {
      data = {
        location = {
          sourceDirectories = [ settings.dataDir ];
          repositories = [ "ssh://dietpi@dietpi/mnt/dietpi_userdata/backups/data" ];
        };
        retention = {
          keepWithin = "1d";
          keepDaily = 7;
          keepWeekly = 4;
        };
      };
      media = {
        location = {
          sourceDirectories = [ settings.mediaDir ];
          repositories = [ "ssh://dietpi@dietpi/mnt/dietpi_userdata/backups/media"];
        };
        retention = {
          keepWithin = "2d";
          keepHourly = 2;
          keepDaily = 7;
          keepWeekly = 4;
          keepMontly = 6;
          keepYearly = -1;
        };
      };
    };
  };
  services.borgmatic = {
    enable = true;
    frequency = "hourly";
  };
}
