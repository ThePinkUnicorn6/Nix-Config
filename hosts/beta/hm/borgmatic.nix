{ config, lib, pkgs, settings, ... }:

{
  programs.borgmatic = {
    enable = true;
    backups = {
      configurations = {
        location = {
          sourceDirectories = [ settings.dataDir ];
          repositories = [ "ssh://dietpi@alpha/mnt/dietpi_userdata/backups/data" ];
        };
        retenetion = {
          keepWithin = "1d";
          keepDaily = 7;
          keepWeekly = 4;
        }
      };
      media = {
        location = {
          sourceDirectories = [ settings.mediaDir ];
          repositories = [ "ssh://dietpi@alpha/mnt/dietpi_userdata/backups/media"];
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
