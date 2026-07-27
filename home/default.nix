{
  pkgs,
  config,
  ...
}:
let
  c = config.lib.stylix.colors;
  u = config.home.username;
  lazyPluginsLocalPath = ".local/share/nvim/lazy/blink.cmp";
  userPortals = "/etc/profiles/per-user/${u}/share/xdg-desktop-portal/portals";
  language-servers = pkgs.symlinkJoin {
    name = "language-servers";
    paths = with pkgs; [
      kotlin-language-server
      jdt-language-server
    ];
  };
  plugins = pkgs.symlinkJoin {
    name = "vscode-extensions";
    paths = with pkgs.vscode-extensions.vscjava; [
      vscode-java-debug
      vscode-java-test
      vscode-java-pack
    ];
  };
in
{
  imports = [
    ./programs.nix
    ./hyprland.nix
  ];

  home = {
    stateVersion = "25.05";
    pointerCursor = {
      enable = true;
      name = "Nordzy-cursors-hyprcursor";
      package = pkgs.nordzy-cursor-theme;
      gtk.enable = true;
      x11.enable = true;
    };
    file.${lazyPluginsLocalPath}.source = "${pkgs.vimPlugins.blink-cmp}";
    # file.".local/share/vscode-extensions".source = "${plugins}/share/vscode/extensions";
    # file.".local/share/language-servers".source = "${language-servers}";
    packages = with pkgs; [
      # android-studio
      fzy
      tree-sitter
      spring-boot-cli
      kotlin-language-server
      arp-scan
      bash-language-server
      lua-language-server
      lua
      bemenu
      bluetuith
      brave
      breakpointHook
      breakpointHookCntr
      brightnessctl
      # discord
      emacs
      evtest
      gdb
      git-filter-repo
      gnupg
      gpg-tui
      grim
      hypridle
      hyprlock
      hyprpaper
      jdt-language-server
      jetbrains.idea-oss
      libnotify
      lombok
      mako
      maven
      nixd
      nordzy-cursor-theme
      notify-desktop
      npins
      openmw
      p7zip
      pass
      pcsx2
      pinentry-curses
      playerctl
      ppsspp
      prismlauncher
      protontricks
      python3
      qbittorrent
      simple-mtpfs
      slurp
      spotify
      steam
      system-config-printer
      telegram-desktop
      unzip
      valgrind
      vlc
      vulkan-tools
      walker
      waybar
      waybar-module-music
      wev
      wezterm
      wiremix
      wlogout
      yazi
      zenity
      zip
      zscroll
    ];
  };

  # gtk.gtk4.theme = null;

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

  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-termfilechooser
      ];

      config.common = {
        default = [ "*" ];
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser.portal";
      };
    };
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
      categories = [
        "System"
        "FileManager"
        "FileTools"
        "ConsoleOnly"
      ];
      terminal = true;
      exec = "${pkgs.wezterm}/bin/wezterm start --class popup -- ${pkgs.yazi}/bin/yazi %u";
      mimeType = [ "inode/directory" ];
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];
      };
    };
  };

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets = {
      hyprlock.enable = false;
      neovim.enable = false;
      hyprland.enable = false;
      waybar.enable = false;
      # qutebrowser.enable = false;
      # librewolf = {
      #   enable = true;
      #   colorTheme.enable = true;
      #   colors.enable = true;
      #   profileNames = [ "detective_shrimp" ];
      # };
    };
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
      $base00H = #${c.withHashtag.base00}
      $base01H = #${c.withHashtag.base01}
      $base02H = #${c.withHashtag.base02}
      $base03H = #${c.withHashtag.base03}
      $base04H = #${c.withHashtag.base04}
      $base05H = #${c.withHashtag.base05}
      $base06H = #${c.withHashtag.base06}
      $base07H = #${c.withHashtag.base07}
      $base08H = #${c.withHashtag.base08}
      $base09H = #${c.withHashtag.base09}
      $base0AH = #${c.withHashtag.base0A}
      $base0BH = #${c.withHashtag.base0B}
      $base0CH = #${c.withHashtag.base0C}
      $base0DH = #${c.withHashtag.base0D}
      $base0EH = #${c.withHashtag.base0E}
      $base0FH = #${c.withHashtag.base0F}

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

  xdg.configFile."stylix/palette.lua" = {
    enable = true;
    text = ''
      return {        
        base00H = "#${c.withHashtag.base00}",
        base01H = "#${c.withHashtag.base01}",
        base02H = "#${c.withHashtag.base02}",
        base03H = "#${c.withHashtag.base03}",
        base04H = "#${c.withHashtag.base04}",
        base05H = "#${c.withHashtag.base05}",
        base06H = "#${c.withHashtag.base06}",
        base07H = "#${c.withHashtag.base07}",
        base08H = "#${c.withHashtag.base08}",
        base09H = "#${c.withHashtag.base09}",
        base0AH = "#${c.withHashtag.base0A}",
        base0BH = "#${c.withHashtag.base0B}",
        base0CH = "#${c.withHashtag.base0C}",
        base0DH = "#${c.withHashtag.base0D}",
        base0EH = "#${c.withHashtag.base0E}",
        base0FH = "#${c.withHashtag.base0F}",

        base00 = "rgba(${c.base00-rgb-r},${c.base00-rgb-g},${c.base00-rgb-b},1)",
        base01 = "rgba(${c.base01-rgb-r},${c.base01-rgb-g},${c.base01-rgb-b},1)",
        base02 = "rgba(${c.base02-rgb-r},${c.base02-rgb-g},${c.base02-rgb-b},1)",
        base03 = "rgba(${c.base03-rgb-r},${c.base03-rgb-g},${c.base03-rgb-b},1)",
        base04 = "rgba(${c.base04-rgb-r},${c.base04-rgb-g},${c.base04-rgb-b},1)",
        base05 = "rgba(${c.base05-rgb-r},${c.base05-rgb-g},${c.base05-rgb-b},1)",
        base06 = "rgba(${c.base06-rgb-r},${c.base06-rgb-g},${c.base06-rgb-b},1)",
        base07 = "rgba(${c.base07-rgb-r},${c.base07-rgb-g},${c.base07-rgb-b},1)",
        base08 = "rgba(${c.base08-rgb-r},${c.base08-rgb-g},${c.base08-rgb-b},1)",
        base09 = "rgba(${c.base09-rgb-r},${c.base09-rgb-g},${c.base09-rgb-b},1)",
        base0A = "rgba(${c.base0A-rgb-r},${c.base0A-rgb-g},${c.base0A-rgb-b},1)",
        base0B = "rgba(${c.base0B-rgb-r},${c.base0B-rgb-g},${c.base0B-rgb-b},1)",
        base0C = "rgba(${c.base0C-rgb-r},${c.base0C-rgb-g},${c.base0C-rgb-b},1)",
        base0D = "rgba(${c.base0D-rgb-r},${c.base0D-rgb-g},${c.base0D-rgb-b},1)",
        base0E = "rgba(${c.base0E-rgb-r},${c.base0E-rgb-g},${c.base0E-rgb-b},1)",
        base0F = "rgba(${c.base0F-rgb-r},${c.base0F-rgb-g},${c.base0F-rgb-b},1)",
      }
    '';
  };
}
