{config, ...}: let
  c = config.lib.stylix.colors.withHashtag;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  services.hyprpaper.enable = true;
}
