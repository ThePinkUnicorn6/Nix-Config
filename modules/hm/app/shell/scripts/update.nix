{ osConfig, lib, pkgs, settings, ... }:

{
  home.packages = with pkgs; [
    nh
    # Scripts
    (pkgs.writeScriptBin "nu" (''
      #!/usr/bin/env bash

      set -e
      pushd ${settings.dotDir} > /dev/null

      case $1 in
        "install")
          echo "Not implemented yet...";;

        "history")
          git log -p $2;;

        "push")
          echo "Pushing to Origin..."
          git push origin main;;

        "pull")
          echo "Pulling from Origin..."
          git pull;;

        "test")
          # Add all files to commit so the flake can see them.
          git add -A
          ${nh}/bin/nh os test . -H "${osConfig.networking.hostName}" $2;;

        "flake")
          echo "Updating flake lock file..."
          nix flake update .;;

        "remote-switch")
          echo "Building config $3 on machine $2"
	  
          git add -A
          read -rp "Enter commit message (leave blank for generation number): " msg

	        nixos-rebuild switch --flake .#"$3" --target-host $2 --use-remote-sudo

           # If the user has entered no commit message, generate it.
          if ! [[ -n "$msg" ]]; then
            msg=$(nixos-rebuild list-generations | grep current)
          fi
          git commit -am "$msg";;
	  
      	"remote-test")
          echo "Testing config $3 on machine $2"
          nixos-rebuild test --flake .#"$3" --target-host $2 --use-remote-sudo;;
	
        *)
          git add -A
          read -rp "Enter commit message (leave blank for generation number): " msg
          ${nh}/bin/nh os switch . -H "${osConfig.networking.hostName}" $1

          # If the user has entered no commit message, generate it.
          if ! [[ -n "$msg" ]]; then
            msg=$(nixos-rebuild list-generations | grep current)
          fi
          git commit -am "$msg"
      esac

      popd > /dev/null
    ''))
  ];
}
