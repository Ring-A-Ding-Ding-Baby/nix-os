{ pkgs, ... }:
let
  fira = pkgs.nerd-fonts.fira-code;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darkmoss.yaml";
    autoEnable = true;

    fonts = {
      serif = {
        package = fira;
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        package = fira;
        name = "FiraCode Nerd Font";
      };
      monospace = {
        package = fira;
        name = "FiraCode Nerd Font Mono";
      };
      sizes = {
        desktop = 15;
        applications = 15;
        terminal = 15;
      };
    };
  };
}
