{ config, lib, pkgs, ... }:

{
  programs.corectrl = {
    enable = true;
  };
  hardware.amdgpu.overdrive.enable = true;
  services.wivrn = {
    enable = true;
    openFirewall = true;
  
    # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
    # will automatically read this and work with WiVRn (Note: This does not currently
    # apply for games run in Valve's Proton)
    defaultRuntime = true;

    # Run WiVRn as a systemd service on startup
    autoStart = false;

    # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
    config = {
      enable = true;
      json = {
        application = pkgs.wlx-overlay-s;
        # 1.0x foveation scaling
        scale = 1.0;
        # 100 Mb/s
        bitrate = 50000;
        encoders = [
          {
            encoder = "vaapi";
            codec = "h265";
            # 1.0 x 1.0 scaling
            width = 1.0;
            height = 1.0;
            offset_x = 0.0;
            offset_y = 0.0;
          }
        ];
      };
    };
  };
}
