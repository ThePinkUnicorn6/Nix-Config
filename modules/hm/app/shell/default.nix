{ pkgs, settings, ... }:
let
  # My shell aliases
  myAliases = {
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    gitfetch = "onefetch";
    neofetch = "disfetch";
    cd = "z";
    e = "emacsclient -c";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    initContent = ''
      disfetch
      eval $(thefuck --alias)
      mcd () {
        mkdir $1
        cd $1
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "thefuck" "sudo" "git" ];
      theme = "bira";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  home.packages = with pkgs; [
    thefuck
    disfetch
    onefetch
    bat
    bottom
    fd
    bc
    direnv
    nix-direnv
    tldr
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}

