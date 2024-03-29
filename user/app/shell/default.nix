{ pkgs, settings, ... }:
let
  # My shell aliases
  myAliases = {
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    gitfetch = "onefetch";
    neofetch = "disfetch";
    ls = "eza";
    # update = "sudo nixos-rebuild switch --flake ~/nixos/flake.nix#system";
    # update-test = "sudo nixos-rebuild test --flake ~/nixos/flake.nix#system";
    # update-flake = "nix flake update ~/nixos && sudo nixos-rebuild switch --flake ~/nixos/flake.nix#system";
    # update-list = "nixos-rebuild dry-build --flake ~/nixos/flake.nix#system";
    cd = "z";
  };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    initExtra = ''
      disfetch
      eval $(thefuck --alias)
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
    eza
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}

