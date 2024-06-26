{ pkgs, settings, ... }:
{
  home.packages = with pkgs; [
    gh
  ];
  programs.git = {
    enable = true;
    userName = "ThePinkUnicorn6";
    userEmail = settings.git-email;
  };
}
