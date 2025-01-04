{ config, lib, pkgs, ... }:
let
  openrgb-override = (pkgs.openrgb-with-all-plugins.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "7b454ce5";
      hash = "sha256-64JPX/RMVYbGU26ZMssyBPbNEUFyTi4/SXI9i3ZLzNc=";
    };
    postPatch = oldAttrs.postPatch + ''
      substituteInPlace scripts/build-udev-rules.sh \
        --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
    '';
  }));
in{
  services.hardware.openrgb = {
    enable = true;
    package = openrgb-override;
  };
  environment.systemPackages = [
    openrgb-override
  ];
}
