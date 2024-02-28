{ config, lib, pkgs, settings, ... }:

{
  home.packages = with pkgs; [
    # Scripts
    (pkgs.writeScriptBin "update" (''
      #!/usr/bin/env bash

      set -e
      pushd ''+settings.system.dotDir+'' > /dev/null

      git --no-pager diff -U0

      case $1 in
        "log")
          cat "update.log";;

        "test")
          echo "Building test config..."
          # Add all files to commit so the flake can see them.
          git add -A

          # Build test system.
          sudo nixos-rebuild test --flake .#system  &>update.log || (cat update.log | grep --color error && false)
          echo "NixOS Test Built OK!";;

        "flake")
          echo "Updating flake lock file..."
          nix flake update .;;

        "commit")
          echo "Building config and committing..."
          git add -A
          read -rp "Enter commit message: " msg
          sudo nixos-rebuild switch --flake .#system  &>update.log || (cat update.log | grep --color error && false)
          git commit -am "$msg"
          echo "NixOS Rebuilt OK!";;

        *)
          echo "Building config and committing..."
          git add -A

          sudo nixos-rebuild switch --flake .#system  &>update.log || (cat update.log | grep --color error && false)
          current=$(nixos-rebuild list-generations | grep current)
          git commit -am "$current"
          echo "NixOS Rebuilt OK!";;
      esac

      popd > /dev/null
    ''))
  ];
}
