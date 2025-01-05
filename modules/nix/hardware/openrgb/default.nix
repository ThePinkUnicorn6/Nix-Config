{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      openrgb-new = (prev.openrgb.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitLab {
          owner = "CalcProgrammer1";
          repo = "OpenRGB";
          rev = "c4917d30b027becd2d9f639deb975006e58b59ba";
          hash = "sha256-V9pwdiRkeaX8KPzilbgc1cGLukzatcvtuAkpjSlhdwA=";
        };
        postPatch = oldAttrs.postPatch + ''
          substituteInPlace scripts/build-udev-rules.sh \
            --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
        '';
      }));
      
      openrgb-plugin-hardwaresync =  (prev.openrgb-plugin-hardwaresync.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitLab {
          owner = "OpenRGBDevelopers";
          repo = "OpenRGBHardwareSyncPlugin";
          rev = "bbd365f974e423dfc2d3e3adabffdcc027ac0959";
          hash = "sha256-De0ARYw06yNMAt+QrWEe1jCg0AfAw7sX68L276pZXfA=";
          fetchSubmodules = true;
        };
        postPatch = ''
          # Use the source of openrgb from nixpkgs instead of the submodule
          rm -r OpenRGB
          ln -s ${final.openrgb.src} OpenRGB
          # Remove prebuilt stuff
          rm -r dependencies/lhwm-cpp-wrapper
        '';
      }));
      
      openrgb-plugin-effects =  (prev.openrgb-plugin-effects.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitLab {
          owner = "OpenRGBDevelopers";
          repo = "OpenRGBEffectsPlugin";
          rev = "f05a38bb";
          hash = "sha256-FCrtY7XcbhQPBMBn02yJ5G/5UJVzlfF+Xa/xSonbHEo=";
          fetchSubmodules = true;
        };
      }));
    })
  ];
  services.hardware.openrgb = {
    enable = true;
    package = (pkgs.openrgb.withPlugins [
      pkgs.openrgb-plugin-hardwaresync
      pkgs.openrgb-plugin-effects
    ]);
  };
  environment.systemPackages = with pkgs; [
    (pkgs.openrgb.withPlugins [
      pkgs.openrgb-plugin-hardwaresync
      pkgs.openrgb-plugin-effects
    ])
  ];
}
