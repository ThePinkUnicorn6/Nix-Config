{ pkgs, ... }:
let
  myAliases = {
    om = "ollama run mistral";
    oc = "ollama run codellama:13b";
    ot = "ollama run tinyllama";
    ol = "ollama run llama3";
  };
in
{
  home.packages = with pkgs; [
    ollama
  ];
  programs.zsh.shellAliases = myAliases; 
}
