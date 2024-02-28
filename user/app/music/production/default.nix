{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    reaper
    yabridge
    yabridgectl
    surge-XT
    helm
    vital
    cardinal
    drumgizmo
    x42-avldrums
  ];
  home.sessionVariables = {
    WINEFSYNC="1";
  };
  programs.zsh.sessionVariables = {
    WINEFSYNC="1";
  };
  programs.bash.sessionVariables = {
    WINEFSYNC="1";
  };

}
