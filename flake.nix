{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    musnix.url = "github:musnix/musnix";
    mach-nix.url = "github:DavHau/mach-nix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/ThePinkUnicorn6/nix-settings?ref=main";
      flake = true;
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, stylix, musnix, mach-nix, secrets, ... }:
    let
      inherit (self) outputs;
      #settings = import ./settings.nix;
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
            # ./options.nix
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
      };
    };
}
