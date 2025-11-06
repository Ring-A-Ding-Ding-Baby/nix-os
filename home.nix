{
  pkgs,
  config,
  lib,
  ...
}: let
  c = config.lib.stylix.colors;
  rgb = hex: "rgb(${hex})";
in {
  imports = [
    ./hyprland.nix
    ./hypr/binds.nix
    ./hypr/waybar.nix
  ];

  home.username = "shrimp";
  home.homeDirectory = "/home/shrimp";

  home.packages = with pkgs; [
    hyprlock
    wlogout
    hyprpaper
    mako
    bemenu
    walker
    jetbrains.idea-community-src
    vscode
    wezterm
    waybar
    telegram-desktop
    brave
    grim
    slurp
    bluetuith
    wiremix
    rustup

    i3status-rust
    qbittorrent
    steam
    openmw
  ];

  programs.git = {
    enable = true;
    settings.user.email = "ebachvictor@gmail.com";
    settings.user.name = "Ring-A-Ding-Ding-Baby";
  };

  programs.diff-highlight = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.home-manager.enable = true;
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        font_size = 11.0,
        enable_tab_bar = false,
        font = wezterm.font("IosevkaTerm Nerd Font"),
      }'';
  };
  services = {
    mako.enable = true;
  };
  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };
        input-field = [
          {
            halign = "center";
            valign = "center";
            position = "0, 0";
            size = "500, 500";
            rounding = 0;
            outline_thickness = 0;
            outer_color = rgb c.base00;
            inner_color = rgb c.base00;
            font_color = rgb c.base05;

            dots_size = 0.3;
            dots_text_format = "👌🏼";
            dots_spacing = 0.0;
            placeholder_text = "🫵🏻";
            fail_text = "🖕🏻";
            dots_center = true;
            fade_on_empty = false;
            fade_timeout = 0;

            fail_color = rgb c.base00;
            check_color = rgb c.base00;
          }
        ];

        background = [{color = rgb c.base00;}];
      };
    };
    wlogout.enable = true;
  };

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets.hyprlock.enable = false;
  };

  home.stateVersion = "25.05";
}
