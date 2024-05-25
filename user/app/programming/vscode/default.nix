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
    };
  };
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
}
