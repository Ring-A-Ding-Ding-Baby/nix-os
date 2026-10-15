{ lib, userName, ... }: {
  systemd.user.services.hyprpaper.Service.WorkingDirectory =
    lib.mkForce "/home/${userName}/.config/hypr/";
  services.hyprpaper = {
    enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "lua";
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
}
