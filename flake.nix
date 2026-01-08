{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs.url = "git+file:../nixpkgs?ref=openrgb-plugin-visualmap";
#    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    musnix.url = "github:musnix/musnix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/ThePinkUnicorn6/nix-settings?ref=main";
      flake = true;
    };
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, stylix, musnix, niri, secrets, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      vars = secrets.vars;
      
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];
      # Function to generate a set based on supported systems:
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
      
      # Patches
      nixpkgsFor = forAllSystems (system: let
        pkgs = import nixpkgs { inherit system; };
        patchedPkgs = pkgs.applyPatches {
          name = "nixpkgs-patched-${nixpkgs.shortRev}";
          src = nixpkgs;
          patches = [
#            (pkgs.fetchpatch {
#              url = "https://github.com/NixOS/nixpkgs/commit/df4f16e2b2c4dfccf3081961095a537f0e37a558.patch";
#              sha256 = "";
#            })
          ];
        };
      in import patchedPkgs { inherit system; });
    in{
      nixosConfigurations =  {
        desktop = let
          system = "x86_64-linux";
          pkgs = nixpkgsFor system;
          settings = {
            dotDir = "/home/${vars.name}/nix";
            username = vars.name;
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            wm = ["hyprland"];
            dm = "tuigreet";
            theme = "stella"; # Find themes at https://tinted-theming.github.io/base16-gallery/
            wallpaper = ./wallpapers/tanger_prefer_not_to_say_wallpaper_4K.png;
            reThemeWall = true;
            loc = vars.loc;
          };
        in lib.nixosSystem {
          modules = [
            ./hosts/desktop/nix
            musnix.nixosModules.musnix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${vars.name}".imports = [ ./hosts/desktop/hm ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit settings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
        };

        beta = let
          system = "x86_64-linux";
          pkgs = nixpkgsFor system;
          settings = {
            dotDir = "/home/beta/nix";
            username = "beta";
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            passwords = vars.passwords;
            domainName = "home.lan";
            tailscaleIP = "100.100.212.90";
            dataDir = "/drive/data";
            mediaDir = "/drive/media";
          };
        in lib.nixosSystem {
          modules = [
            ./hosts/beta/nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."beta".imports = [ ./hosts/beta/hm ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit settings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
        };

        laptop = let
          system = "x86_64-linux";
          pkgs = nixpkgsFor system;
          settings = {
            dotDir = "/home/${vars.name}/nix";
            username = vars.name;
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            wm = [  "sway" ];
            dm = "tuigreet";
            theme = "everforest"; # Find themes at https://tinted-theming.github.io/base16-gallery/
            wallpaper = ./wallpapers/t440p_explodedview.png;
            reThemeWall = true;
            loc = vars.loc;
          };
        in lib.nixosSystem {
          modules = [
            ./hosts/laptop/nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${vars.name}".imports = [ ./hosts/laptop/hm ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit settings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
        };
       mac = let
          system = "x86_64-linux";
          pkgs = nixpkgsFor system;
          settings = {
            dotDir = "/home/${vars.name}/nix";
            username = vars.name;
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            wm = [ "hyprland" ];
            dm = "tuigreet";
            theme = "gruvbox-material-dark-soft"; # Find themes at https://tinted-theming.github.io/base16-gallery/
            wallpaper = ./wallpapers/tanger_prefer_not_to_say_wallpaper_4K.png;
            reThemeWall = false;
            loc = vars.loc;
          };
        in lib.nixosSystem {
          modules = [
            ./hosts/mac/nix
            musnix.nixosModules.musnix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${vars.name}".imports = [ ./hosts/mac/hm ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit settings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
          };
        };
      };

      # Installer from https://gitlab.com/librephoenix/nixos-config/-/blob/main/flake.nix
      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages."x86_64-linux".install;
          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ git gh ];
            text = ''
gh auth login || true
git clone https://github.com/thepinkunicorn6/nix-config ~/nix
cd ~/nix
read -r -p "Enter name of flake config to use: " hostname
nixos-generate-config --show-hardware-config > ~/nix/hosts/"$hostname"/nix/hardware-configuration.nix
git add .
nixos-rebuild switch --flake ~/nix#"$hostname" --sudo
'';
          };
        });
      
      apps = forAllSystems (system: {
        default = self.apps.${system}.install;
        install = {
          type = "app";
          program = "${self.packages.${system}.install}/bin/install";
        };
      });
    };
}
