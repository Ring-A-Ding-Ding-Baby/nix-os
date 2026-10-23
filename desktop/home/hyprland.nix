{
  lib,
  pkgs,
  userName,
  hyprland,
  hyprPkgs,
  ...
}:
{
  systemd.user.services.hyprpaper.Service.WorkingDirectory =
    lib.mkForce "/home/${userName}/.config/hypr/";
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "lua";
    package = hyprPkgs.hyprland;
    portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
  };
  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    hyprlock.enable = true;
  };

}
