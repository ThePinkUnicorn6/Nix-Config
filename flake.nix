{
  description = "Nixos config flake ";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    musnix.url = "github:musnix/musnix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/ThePinkUnicorn6/nix-settings?ref=main";
      flake = true;
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, comin, stylix, musnix, secrets, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      vars = secrets.vars;
    in{
      nixosConfigurations =  {
        nixos-desktop = let
          settings = {
            dotDir = "/home/${vars.name}/nix";
            username = vars.name;
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            wm = "hyprland";
            dm = "tuigreet";
            theme = "gruvbox-dark-soft";
            wallpaper = ./wallpapers/city_sunset.png;
            reThemeWall = true;
            font = "Iosevka Aile";
            fontPkg = "iosevka";
          };
        in lib.nixosSystem {
          system = "x86_64-linux";
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
          settings = {
            dotDir = "/home/beta/nix";
            username = "beta";
            name = vars.name;
            personal-email = vars.personal-email;
            git-email = vars.git-email;
            domainName = "home.lan";
            tailscaleIP = "100.100.212.90";
            serviceConfigRoot = "/drive/data";
            serviceMediaRoot = "/drive/media";
          };
        in lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/beta/nix
            comin.nixosModules.comin
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

        rpi2 = nixpkgs.lib.nixosSystem {
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-armv7l-multiplatform.nix"
            {
              nixpkgs.config.allowUnsupportedSystem = true;
              nixpkgs.hostPlatform.system = "armv7l-linux";
              nixpkgs.buildPlatform.system = "x86_64-linux"; #If you build on x86 other wise changes this.
              system.stateVersion = "24.05";
              # ... extra configs as above
            }
          ];
        };
      };
      images.rpi2 = outputs.nixosConfigurations.rpi2.config.system.build.sdImage;
    };
}
