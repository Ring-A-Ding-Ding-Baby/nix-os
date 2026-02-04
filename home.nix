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
  home.pointerCursor = {
    enable = true;
    name = "Nordzy-cursors-hyprcursor";
    package = pkgs.nordzy-cursor-theme;
    gtk.enable = true;
    x11.enable = true;
    #hyprcursor = {
    #  enable = true;
    #};
  };
  home.packages = with pkgs; [
    simple-mtpfs
    nordzy-cursor-theme
    libreoffice
    brightnessctl
    prismlauncher
    playerctl
    evtest
    wev
    zip
    p7zip
    unzip
    hyprlock
    hypridle
    ppsspp
    pcsx2
    wlogout
    hyprpaper
    mako
    libnotify
    notify-desktop
    bemenu
    walker
    jetbrains.idea-community-src
    vscode
    wezterm
    waybar
    telegram-desktop
    chromium
    python3
    brave
    grim
    slurp
    bluetuith
    wiremix
    gradle
    rustup
    rust-bindgen
    vlc
    i3status-rust
    qbittorrent
    steam
    openmw
    vulkan-tools
    discord
    spotify
    gpg-tui
    gnupg
    pinentry-curses
    protontricks
    pass
    yazi
  ];

  programs.git = {
    enable = true;
    settings.user.email = "ebachvictor@gmail.com";
    settings.user.name = "Ring-A-Ding-Ding-Baby";
    settings.pull.rebase = true;
  };

  programs.diff-highlight = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.gpg.enable = true;
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
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
      pinentry.program = "pinentry-curses";
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }

          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }

          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }

          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    playerctld.enable = true;
    mako = {
      enable = true;
      settings = {
        border-size = 0;
        default-timeout = 1800;
        ignore-timeout = 1;
        margin = 0;
        max-visible = 3;
        anchor = "top-center";
      };
    };
  };
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    hyprlock = {
      enable = true;
      settings = {
        background = [{path = "${config.home.homeDirectory}/wallpapers/wallpaper.jpg";}];
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };

        label = {
          text = "$LAYOUT[E,R]";
          halign = "right";
          valign = "top";
          font_size = 14;
          position = "-10,-10";
        };

        input-field = [
          {
            halign = "left";
            valign = "top";
            position = "0, 0";
            size = "450, 50";
            rounding = 0;
            outline_thickness = 0;
            outer_color = "rgba(0,0,0,0)";
            inner_color = "rgba(0,0,0,0)";
            font_color = rgb c.base05;

            dots_size = 0.3;
            dots_text_format = "+";
            dots_spacing = 0.0;
            dots_center = false;
            placeholder_text = "";
            fail_text = "";
            fade_on_empty = false;
            fade_timeout = 0;
            color = "rgba(0,0,0,0)";
            fail_color = "rgba(0,0,0,0)";
            check_color = "rgba(0,0,0,0)";
          }
        ];
      };
    };
    wlogout.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-termfilechooser
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;

      config = {
        common = {
          default = ["hyprland" "gtk"];
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
        };
      };
    };
    desktopEntries.yazi = {
      name = "Yazi";
      genericName = "File Manager";
      comment = "Terminal file manager";
      categories = ["System" "FileManager" "FileTools" "ConsoleOnly"];
      terminal = true;
      exec = "${pkgs.wezterm}/bin/wezterm start --class popup -- ${pkgs.yazi}/bin/yazi %u";
      mimeType = ["inode/directory"];
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["yazi.desktop"];
      };
    };

    configFile."xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd='${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh'
      create_help_file=0
      default_dir=$HOME
      env=TERMCMD='${pkgs.wezterm}/bin/wezterm start --class popup --'
          EDITOR=nvim
      open_mode=suggested
      save_mode=last
    '';
  };

  stylix = {
    enable = true;
    autoEnable = true;
    fonts.sizes.desktop = 11;
    polarity = "dark";
    targets.hyprlock.enable = false;
    targets.waybar.addCss = true;
  };

  home.stateVersion = "25.05";
}
