{ lib, pkgs, stylix, settings, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/${settings.user.theme}.yaml";
  polarity = (builtins.readFile "${(pkgs.runCommand "getPolarity" {} "${pkgs.yq}/bin/yq -r .variant ${theme} >> $out")}");
in
{
  stylix = {
    base16Scheme = theme;
    polarity = if "${polarity}" == "light" then "light" else "dark";
  };
  qt.platformTheme = "qt5ct";
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
