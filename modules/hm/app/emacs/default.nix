{ config, pkgs, settings,... }:
{
  imports = [
#    ./doom
    ./vanilla

    ../tex
    ../../lang/plantuml
  ];
 
  home.packages = with pkgs; [
    ripgrep
    emacsPackages.sqlite3
    emacs-all-the-icons-fonts
  ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
  services.emacs.enable = true;
}
