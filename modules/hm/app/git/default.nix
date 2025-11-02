{ pkgs, settings, ... }:
{
  home.packages = with pkgs; [
    gh
  ];
  programs.git = {
    enable = true;
    settings = {
      user.name = "ThePinkUnicorn6";
      user.email = settings.git-email;
    };
  };
}
