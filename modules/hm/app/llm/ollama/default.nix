{ pkgs, settings, ... }:
let
  myAliases = {
    om = "ollama run mistral";
    oc = "ollama run codellama:13b";
    ot = "ollama run tinyllama";
    ol = "ollama run llama3";
  };
in
{
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_MODELS = "/home/${settings.username}/shared-files/.ollama/models";
      HSA_OVERRIDE_GFX_VERSION = "10.1.0";
    };
    acceleration = "rocm";
  };
  programs.zsh.shellAliases = myAliases; 
}
