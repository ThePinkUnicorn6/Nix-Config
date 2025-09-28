{ config, lib, pkgs, settings, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/${settings.theme}.yaml";
  # Location of the wallpaper set in settings.
  wallfile = settings.wallpaper;
  # Use imageMagic to change the colours if the image to use the colour scheme.
  wallpaper = if settings.reThemeWall then pkgs.runCommand "wallout.png" {} ''
        BASE00="#"$(${pkgs.yq}/bin/yq -r .palette.base00 ${theme})
        BASE01="#"$(${pkgs.yq}/bin/yq -r .palette.base01 ${theme})
        BASE02="#"$(${pkgs.yq}/bin/yq -r .palette.base02 ${theme})
        BASE03="#"$(${pkgs.yq}/bin/yq -r .palette.base03 ${theme})
        BASE04="#"$(${pkgs.yq}/bin/yq -r .palette.base04 ${theme})
        BASE05="#"$(${pkgs.yq}/bin/yq -r .palette.base05 ${theme})
        BASE06="#"$(${pkgs.yq}/bin/yq -r .palette.base06 ${theme})
        BASE07="#"$(${pkgs.yq}/bin/yq -r .palette.base07 ${theme})
        BASE08="#"$(${pkgs.yq}/bin/yq -r .palette.base08 ${theme})
        BASE09="#"$(${pkgs.yq}/bin/yq -r .palette.base09 ${theme})
        BASE0A="#"$(${pkgs.yq}/bin/yq -r .palette.base0A ${theme})
        BASE0B="#"$(${pkgs.yq}/bin/yq -r .palette.base0B ${theme})
        BASE0C="#"$(${pkgs.yq}/bin/yq -r .palette.base0C ${theme})
        BASE0D="#"$(${pkgs.yq}/bin/yq -r .palette.base0D ${theme})
        BASE0E="#"$(${pkgs.yq}/bin/yq -r .palette.base0E ${theme})
        BASE0F="#"$(${pkgs.yq}/bin/yq -r .palette.base0F ${theme})
        ${pkgs.imagemagick}/bin/magick convert -size 1x8 xc:none +antialias -depth 8 -define png:color-type=2 \
        \( +clone -fill "$BASE00" -draw 'color 0,0 point' \) \
        \( +clone -fill "$BASE01" -draw 'color 0,1 point' \) \
        \( +clone -fill "$BASE02" -draw 'color 0,2 point' \) \
        \( +clone -fill "$BASE03" -draw 'color 0,3 point' \) \
        \( +clone -fill "$BASE04" -draw 'color 0,4 point' \) \
        \( +clone -fill "$BASE05" -draw 'color 0,5 point' \) \
        \( +clone -fill "$BASE06" -draw 'color 0,6 point' \) \
        \( +clone -fill "$BASE07" -draw 'color 0,7 point' \) \
        \( +clone -fill "$BASE08" -draw 'color 0,0 point' \) \
        \( +clone -fill "$BASE09" -draw 'color 0,1 point' \) \
        \( +clone -fill "$BASE0A" -draw 'color 0,2 point' \) \
        \( +clone -fill "$BASE0B" -draw 'color 0,3 point' \) \
        \( +clone -fill "$BASE0C" -draw 'color 0,4 point' \) \
        \( +clone -fill "$BASE0D" -draw 'color 0,5 point' \) \
        \( +clone -fill "$BASE0E" -draw 'color 0,6 point' \) \
        \( +clone -fill "$BASE0F" -draw 'color 0,7 point' \) \
        -append palette.png
        ${pkgs.imagemagick}/bin/magick convert "${wallfile}" -dither FloydSteinberg -ordered-dither o8x8 -remap palette.png -type truecolor $out
  ''
    else /. + wallfile;
in
{
  # home.file.".config/hypr/hyprpaper.conf".text = ''
  #   preload = ${config.stylix.image}
  #   wallpaper = HDMI-A-1,${config.stylix.image}
  #   wallpaper = DP-2,${config.stylix.image}
  #   splash = false
  # '';

  stylix = {
    enable = true;
    image = wallpaper;
    base16Scheme = theme;
    polarity = "dark";
    fonts.sizes = {
      terminal = 12;
      applications = 12;
      popups = 12;
      desktop = 12;
    };
    opacity = {
      applications = 0.8;
      terminal = 0.75;
      popups = 0.75;
    };
    targets = {
      waybar.enable = false;
      alacritty.enable = false;
      vscode.enable = false;
      emacs.enable = false;
    };

    fonts = {
      monospace = {
        name = "Iosevka Term";
        package = pkgs.iosevka;
      };
      serif = {
        name = "Iosevka Aile";
        package = pkgs.iosevka;
      };
      sansSerif = {
        name = "Iosevka Etoile";
        package = pkgs.iosevka;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 32;
    };
  };

  qt = {
    #platformTheme = "qtct";
    enable = true;
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
