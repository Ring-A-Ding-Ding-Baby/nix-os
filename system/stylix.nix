{pkgs, ...}: let
in {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darkmoss.yaml";
    autoEnable = true;

    fonts = {
      serif = {
        package = pkgs.cozette;
        name = "Cozette Vector";
      };
      sansSerif = {
        package = pkgs.cozette;
        name = "Cozette Vector";
      };
      monospace = {
        package = pkgs.cozette;
        name = "Cozette";
      };
      sizes = {
        desktop = 15;
        applications = 15;
        terminal = 15;
      };
    };
  };
}
