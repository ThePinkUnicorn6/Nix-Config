{ config, pkgs, ... }:
let
  colours = config.lib.stylix.colors;
in{
  home.packages = with pkgs; [
    webcord-vencord
  ];

  home.file.".config/WebCord/Themes/stylix-discord.theme".text = ''
/**
* @name base16
* @author ThePinkUnicorn
* @version 1.0.0
* @description base16 theme generated from https://github.com/tinted-theming/schemes
**/

:root {
    --base00: #''+colours.base00+''; /* Black */
    --base01: #''+colours.base01+''; /* Bright Black */
    --base02: #''+colours.base02+''; /* Grey */
    --base03: #''+colours.base03+''; /* Brighter Grey */
    --base04: #''+colours.base04+''; /* Bright Grey */
    --base05: #''+colours.base05+''; /* White */
    --base06: #''+colours.base06+''; /* Brighter White */
    --base07: #''+colours.base07+''; /* Bright White */
    --base08: #''+colours.base08+''; /* Red */
    --base09: #''+colours.base09+''; /* Orange */
    --base0A: #''+colours.base0A+''; /* Yellow */
    --base0B: #''+colours.base0B+''; /* Green */
    --base0C: #''+colours.base0C+''; /* Cyan */
    --base0D: #''+colours.base0D+''; /* Blue */
    --base0E: #''+colours.base0E+''; /* Purple */
    --base0F: #''+colours.base0F+''; /* Magenta */

    --primary-630: var(--base00); /* Autocomplete background */
    --primary-660: var(--base00); /* Search input background */
}

.theme-light, .theme-dark {
    --search-popout-option-fade: none; /* Disable fade for search popout */
    --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
    --home-background: var(--base00);
    --background-primary: rgba(var(--base00), ''+(builtins.toString (config.stylix.opacity.applications))+'');
    --background-secondary: var(--base01);
    --background-secondary-alt: var(--base01);
    --channeltextarea-background: var(--base01);
    --background-tertiary: var(--base00);
    --background-accent: var(--base0E);
    --background-floating: var(--base01);
    --background-modifier-selected: var(--base00);
    --text-normal: var(--base05);
    --text-secondary: var(--base00);
    --text-muted: var(--base03);
    --text-link: var(--base0C);
    --interactive-normal: var(--base05);
    --interactive-hover: var(--base0C);
    --interactive-active: var(--base0A);
    --interactive-muted: var(--base03);
    --header-primary: var(--base06);
    --header-secondary: var(--base03);
    --scrollbar-thin-track: transparent;
    --scrollbar-auto-track: transparent;
}
  '';
}
