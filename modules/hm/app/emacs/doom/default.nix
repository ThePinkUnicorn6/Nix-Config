{ config, lib, pkgs, ... }:

{
  imports = [
    ./config.el.nix
    ./init.el.nix
    ./packages.el.nix
  ];

  home.file.".config/emacs/themes/doom-stylix-theme.el".source = config.lib.stylix.colors {
      template = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
      extension = ".el";
  };
}
