{
  system = {
    system = "x86_64-linux";
    profile = "desktop";
    isNixOS = true;
    displayManager = "tuigreet";
    dotDir = "/home/***REMOVED***/nixos";
  };
  user = {
    name = "***REMOVED***"; # Your name.
    username = "***REMOVED***"; # The name of the user account.
    email = "***REMOVED******REMOVED***"; # Your email (used for git).
    gitName = "ThePinkUnicorn";
    theme = "gruvbox-dark-soft"; # The name of the theme, as in https://tinted-theming.github.io/base16-gallery/.
    wallpaper = /home/***REMOVED***/nixos/themes/wallpapers/city_sunset.png;
    reThemeWall = true; # Re-theme the colours of the paper with imagemagic
    wm = "hyprland";
    font = "Iosevka Aile";
    fontPkg = "iosevka";
    location = {
      lat = ***REMOVED***;
      lon = ***REMOVED***;
    };
  };
}
