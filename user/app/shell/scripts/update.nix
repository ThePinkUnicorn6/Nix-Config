{ config, lib, pkgs, settings, ... }:

{
  home.packages = with pkgs; [

    # Scripts
    (pkgs.writeScriptBin "nu" (''
      #!/usr/bin/env bash

      set -e
      pushd ''+settings.system.dotDir+'' > /dev/null

      case $1 in
        "install")
          echo "Not implemented yet...";;

        "history")
          git log -p $2;;

        "push")
          echo "Pushing to Origin..."
          git push origin main;;

        "test")
          # Add all files to commit so the flake can see them.
          git add -A

          # Build test system. Will use home manager if on another os, and nixos-rebuild if not.

          ${nh}/bin/nh os test . -H system;;

        "flake")
          echo "Updating flake lock file..."
          nix flake update .;;

        *)
          git add -A
          read -rp "Enter commit message (leave blank for generation number): " msg
          ${nh}/bin/nh os switch . -a -H system

          # If the user has entered no comit message, generate it.
          if ! [[ -n "$msg" ]]; then
            msg=$(nixos-rebuild list-generations | grep current)
          fi
          git commit -am "$msg"
      esac

      popd > /dev/null
    ''))
  ];
}
