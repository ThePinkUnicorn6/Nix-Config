{ pkgs, settings,... }:
{
  imports = [ 
    ../../lang/plantuml

    # Emacs config files:
    ./config.el.nix
    ./init.el.nix
    ./packages.el.nix
  ];
 
  home.packages = with pkgs; [
    ripgrep
    emacs-all-the-icons-fonts
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };
  services.emacs.enable = true;
}
