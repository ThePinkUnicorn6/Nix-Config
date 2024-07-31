{ lib, pkgs, stylix, config, settings, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/${settings.theme}.yaml";
  polarity = (builtins.readFile "${(pkgs.runCommand "getPolarity" {} "${pkgs.yq}/bin/yq -r .variant ${theme} >> $out")}");
in
{
  stylix = {
    enable = true;
    homeManagerIntegration.autoImport = true;
    base16Scheme = theme;
    image = config.home-manager.users.${settings.username}.stylix.image;
    polarity = if "${polarity}" == "light" then "light" else "dark";
  };
#  qt.platformTheme.name = "qt5ct";
#  environment.sessionVariables = {
#    QT_QPA_PLATFORMTHEME = "qt5ct";
#  };
}
