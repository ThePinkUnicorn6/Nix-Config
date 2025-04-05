{ config, lib, pkgs, ... }:

{
  imports = [ ../ollama ];
  programs.mods = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default-model = "deepseek-r1:8b";
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "deepseek-r1:8b" = {
              aliases = [ "deepseek" ];
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
