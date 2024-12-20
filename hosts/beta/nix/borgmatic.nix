{ config, lib, pkgs, settings, ... }:

{
  services.borgmatic = {
    enable = true;
    
    configurations = {
      data = {
        source_directories = [ settings.dataDir ];
        repositories = [ {
          path = "ssh://borg@dietpi/mnt/dietpi_userdata/backups/data";
          label = "backupserver";
        }];
        encryption_passphrase = settings.passwords.borg;
        keep_within = "1d";
        keep_daily = 7;
        keep_weekly = 4;
      };
      media = {
        source_directories = [ settings.mediaDir ];
        repositories = [ {
          path = "ssh://borg@dietpi/mnt/dietpi_userdata/backups/media";
          label = "backupserver";
        }];
        encryption_passphrase = settings.passwords.borg;
        keep_within = "2d";
        keep_hourly = 2;
        keep_daily = 7;
        keep_weekly = 4;
        keep_monthly = 6;
        keep_yearly = -1;        
      };
    };
  };
}
