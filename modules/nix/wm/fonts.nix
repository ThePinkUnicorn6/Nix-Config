{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    powerline
    inconsolata
    nerd-fonts.iosevka
    font-awesome
    ubuntu-classic
    terminus_font
  ];
}
