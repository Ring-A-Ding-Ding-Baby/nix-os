{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    uwsm = {
      enable = true;
    };
    hyprland = let
      hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      withUWSM = true;
      package = hypr-pkgs.hyprland;
      portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 1000;
      ohMyZsh = {
        enable = true;
        plugins = ["git" "vi-mode"];
      };
    };
  };
}
