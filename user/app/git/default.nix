{ pkgs, settings, ... }:
{
  programs.git = {
    enable = true;
    userName = settings.user.gitName;
    userEmail = settings.user.email;
  };
}
