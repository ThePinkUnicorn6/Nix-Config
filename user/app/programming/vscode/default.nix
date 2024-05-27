{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      marp-team.marp-vscode
      ms-dotnettools.csharp
    ];
    userSettings = {
      "terminal.external.linuxExec" = "kitty";
      "workbench.colorTheme" = "Default Dark+";
    };
  };
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
}
