{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (with dotnetCorePackages; combinePackages [
      sdk_9_0
    ])
    omnisharp-roslyn
    netcoredbg
  ];
}
