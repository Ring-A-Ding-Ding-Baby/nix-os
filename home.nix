{
  pkgs,
  config,
  ...
}: let
  c = config.lib.stylix.colors;
  u = config.home.username;
  userPortals = "/etc/profiles/per-user/${u}/share/xdg-desktop-portal/portals";
in {
  imports = [
    ./hyprland.nix
  ];

  home.username = "shrimp";
  home.homeDirectory = "/home/shrimp";
  home.pointerCursor = {
    enable = true;
    name = "Nordzy-cursors-hyprcursor";
    package = pkgs.nordzy-cursor-theme;
    gtk.enable = true;
    x11.enable = true;
  };
  home.packages = with pkgs; [
    waybar-module-music
    zenity
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
    jetbrains.idea-oss
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
    zscroll
    git-filter-repo
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
    };
    wlogout.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-termfilechooser
      ];

      config.common = {
        default = ["*"];
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser.portal";
      };
    };
    #THIS SHIT BELOW I DO NOT LIKE THIS APPROACH REALLY BUT NIX FUCKUPS XDG FR FR !!!!
    # I need to rethink my life or/and this uncanny hackery
    configFile."systemd/user/xdg-desktop-portal.service.d/override.conf".text = ''
      [Service]
      Environment="NIX_XDG_DESKTOP_PORTAL_DIR=${userPortals}"
    '';

    configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=yazi-wrapper.sh
        default_dir=$HOME
        env=TERMCMD=wezterm start --class popup --
        open_mode = suggested
        save_mode = last
      '';
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
  };

  stylix = {
    enable = true;
    autoEnable = true;
    fonts.sizes.desktop = 11;
    polarity = "dark";
    targets.hyprlock.enable = false;
    targets.hyprland.enable = false;
    targets.waybar.enable = false;
  };
  xdg.configFile."stylix/palette.css".text = ''
    @define-color  base00 #${c.base00};
    @define-color  base01 #${c.base01};
    @define-color  base02 #${c.base02};
    @define-color  base03 #${c.base03};
    @define-color  base04 #${c.base04};
    @define-color  base05 #${c.base05};
    @define-color  base06 #${c.base06};
    @define-color  base07 #${c.base07};
    @define-color  base08 #${c.base08};
    @define-color  base09 #${c.base09};
    @define-color  base0A #${c.base0A};
    @define-color  base0B #${c.base0B};
    @define-color  base0C #${c.base0C};
    @define-color  base0D #${c.base0D};
    @define-color  base0E #${c.base0E};
    @define-color  base0F #${c.base0F};
    @define-color  base10 #${c.base10};
    @define-color  base11 #${c.base11};
    @define-color  base12 #${c.base12};
    @define-color  base13 #${c.base13};
    @define-color  base14 #${c.base14};
    @define-color  base15 #${c.base15};
    @define-color  base16 #${c.base16};
    @define-color  base17 #${c.base17};
  '';

  xdg.configFile."stylix/palette.conf" = {
    enable = true;
    text = ''
      $base00 = rgb(${c.base00})
      $base01 = rgb(${c.base01})
      $base02 = rgb(${c.base02})
      $base03 = rgb(${c.base03})
      $base04 = rgb(${c.base04})
      $base05 = rgb(${c.base05})
      $base06 = rgb(${c.base06})
      $base07 = rgb(${c.base07})
      $base08 = rgb(${c.base08})
      $base09 = rgb(${c.base09})
      $base0A = rgb(${c.base0A})
      $base0B = rgb(${c.base0B})
      $base0C = rgb(${c.base0C})
      $base0D = rgb(${c.base0D})
      $base0E = rgb(${c.base0E})
      $base0F = rgb(${c.base0F})
    '';
  };

  home.stateVersion = "25.05";
}
