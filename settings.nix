{
  system = {
    system = "x86_64-linux";
    isNixOS = true;
    profile = "desktop";
    displayManager = "gdm";
    dotDir = "/home/USERNAME/nixos";
  };
  user = {
    name = ""; # Your name.
    username = ""; # The name of the user account.
    email = ""; # Your email (used for git).
    gitName = "";
    theme = "caroline"; # The name of the theme in the ./themes folder.
    wallpaper = /home/USERNAME/nixos/themes/wallpapers/city_sunset.png; # Set as "" to use wallpaper in theme file.
    reThemeWall = true; # Re-theme the colours of the paper with imagemagic
    wm = "hyprland";
    font = "Iosevka Aile";
    fontPkg = "iosevka";
    location = {
      lat = 0;
      lon = 0;
    };
  };
}
