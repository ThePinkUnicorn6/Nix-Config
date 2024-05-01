{ pkgs, settings, ... }:
{
  home.packages = with pkgs; [
    gh
  ];
  programs.git = {
    enable = true;
    userName = settings.user.gitName;
    userEmail = settings.user.email;
  };
}
