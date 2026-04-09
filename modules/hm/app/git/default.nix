{ pkgs, settings, ... }:
{
  home.packages = with pkgs; [
    gh
  ];
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user.name = "ThePinkUnicorn6";
      user.email = settings.git-email;
    };
  };
}
