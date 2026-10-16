{ pkgs, ... }:
let
  font = pkgs.nerd-fonts.fira-code;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darkmoss.yaml";
    autoEnable = true;

    fonts = {
      serif = {
        package = font;
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        package = font;
        name = "FiraCode Nerd Font";
      };
      monospace = {
        package = font;
        name = "FiraCode Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        desktop = 15;
        applications = 15;
        terminal = 12;
      };
    };
  };
}
