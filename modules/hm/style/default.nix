{ config, lib, pkgs, settings, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/${settings.theme}.yaml";
  # Location of the wallpaper set in settings.
  wallfile = settings.wallpaper;
  # Use imageMagic to change the colours if the image to use the colour scheme.
  wallpaper = if settings.reThemeWall then pkgs.runCommand "wallout.png" {} ''
  export HOME=$(pwd)
        BASE00=""$(${pkgs.yq}/bin/yq -r .palette.base00 ${theme})
        BASE01=""$(${pkgs.yq}/bin/yq -r .palette.base01 ${theme})
        BASE02=""$(${pkgs.yq}/bin/yq -r .palette.base02 ${theme})
        BASE03=""$(${pkgs.yq}/bin/yq -r .palette.base03 ${theme})
        BASE04=""$(${pkgs.yq}/bin/yq -r .palette.base04 ${theme})
        BASE05=""$(${pkgs.yq}/bin/yq -r .palette.base05 ${theme})
        BASE06=""$(${pkgs.yq}/bin/yq -r .palette.base06 ${theme})
        BASE07=""$(${pkgs.yq}/bin/yq -r .palette.base07 ${theme})
        BASE08=""$(${pkgs.yq}/bin/yq -r .palette.base08 ${theme})
        BASE09=""$(${pkgs.yq}/bin/yq -r .palette.base09 ${theme})
        BASE0A=""$(${pkgs.yq}/bin/yq -r .palette.base0A ${theme})
        BASE0B=""$(${pkgs.yq}/bin/yq -r .palette.base0B ${theme})
        BASE0C=""$(${pkgs.yq}/bin/yq -r .palette.base0C ${theme})
        BASE0D=""$(${pkgs.yq}/bin/yq -r .palette.base0D ${theme})
        BASE0E=""$(${pkgs.yq}/bin/yq -r .palette.base0E ${theme})
        BASE0F=""$(${pkgs.yq}/bin/yq -r .palette.base0F ${theme})
    cat << EOF > palette.json
    {
      "name": "MyTheme",
      "colors": [
        "$BASE00",
        "$BASE01",
        "$BASE02",
        "$BASE03",
        "$BASE04",
        "$BASE05",
        "$BASE06",
        "$BASE07",
        "$BASE08",
        "$BASE09",
        "$BASE0A",
        "$BASE0B",
        "$BASE0C",
        "$BASE0D",
        "$BASE0E",
        "$BASE0F"  
      ]
    }

EOF
    cat palette.json
    ${pkgs.gowall}/bin/gowall convert ${wallfile} -t palette.json --output "out.png"
    ls
    cp out.png $out
  ''
    else /. + wallfile;
in
{
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
      firefox.colorTheme.enable = true;
      qt.enable = false;
    };

    fonts = {
      monospace = {
        name = "Iosevka Term";
        package = pkgs.nerd-fonts.iosevka;
      };
      serif = {
        name = "Iosevka Aile";
        package = pkgs.nerd-fonts.iosevka;
      };
      sansSerif = {
        name = "Iosevka Etoile";
        package = pkgs.nerd-fonts.iosevka;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 32;
    };
  };

  qt = {
#    platformTheme.name = "gnome";
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
