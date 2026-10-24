{
  pkgs,
  config,
  lib,
  ...
}:
let
  c = config.lib.stylix.colors;
  u = config.home.username;
  genPalette =
    fmtfun: attrset:
    (lib.concatLines (
      lib.attrsets.mapAttrsToList fmtfun (
        lib.attrsets.filterAttrs (n: v: builtins.match "base[[:xdigit:]][[:xdigit:]]" n == [ ]) attrset
      )
    ));
  lazyPluginsLocalPath = ".local/share/nvim/lazy/blink.cmp";
  userPortals = "/etc/profiles/per-user/${u}/share/xdg-desktop-portal/portals";
  vscode-extensions = pkgs.symlinkJoin {
    name = "vscode-extensions";
    paths = [
      pkgs.vscode-extensions.vscjava.vscode-java-debug
      pkgs.vscode-extensions.vadimcn.vscode-lldb
    ];
  };
  hyprDots = pkgs.fetchFromGitHub {
    owner = "Ring-A-Ding-Ding-Baby";
    repo = "hyprdots";
    rev = "a6281333950c9b7d3cda26ddb2e91201ef0394e6";
    hash = "sha256-N9+XX4yXQmxcdJIimaK62uYt3Rdpzy8MSbW3Yp9uEH4=";
  };
  wayDots = pkgs.fetchFromGitHub {
    owner = "Ring-A-Ding-Ding-Baby";
    repo = "waybar";
    rev = "7de24c0ed74c604d91250453106c140c2092b7ed";
    hash = "sha256-PLZ7w2ikKCy7Kg4iH77qhz7YkiQ8Q2mcM9HSuuKo4Vk=";
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
    sessionPath = [
      "$HOME/.config/emacs/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    file = {
      ${lazyPluginsLocalPath}.source = "${pkgs.vimPlugins.blink-cmp}";
      ".local/share/vscode-extensions".source = "${vscode-extensions}/share/vscode/extensions";
      ".config/hypr" = {
        source = hyprDots;
        recursive = true;
      };
      ".config/waybar" = {
        source = wayDots;
        recursive = true;
      };
    };
    packages = with pkgs; [
      (callPackage ../palantir-java.nix { })
      discord
      arp-scan
      appimage-run
      bash-language-server
      bemenu
      bluetuith
      brave
      breakpointHook
      breakpointHookCntr
      briar-desktop
      brightnessctl
      cmake
      emacs
      evtest
      fzy
      gdb
      gdb
      git-filter-repo
      gnupg
      gpg-tui
      grim
      hypridle
      hyprpaper
      jdt-language-server
      kooha
      kotlin-language-server
      libnotify
      lombok
      lua
      lua-language-server
      mako
      maven
      nixd
      nixfmt
      nordzy-cursor-theme
      notify-desktop
      npins
      openmw
      p7zip
      pass
      pcsx2
      pinentry-bemenu
      playerctl
      ppsspp
      prismlauncher
      protontricks
      python3
      qbittorrent
      slurp
      spring-boot-cli
      stylua
      system-config-printer
      telegram-desktop
      termshark
      tree-sitter
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
    ];
  };
  # gtk.gtk4.theme = null;
  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-bemenu;
      pinentry.program = "pinentry-bemenu";
      # extraConfig = ''
      #   allow-emacs-pinentry
      #   allow-loopback-pinentry
      # '';
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
      # executable = true;
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
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
        "text/html" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
        "application/pdf" = "com.github.johnfactotum.Foliate.desktop";
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
    };
  };
  xdg.configFile."stylix/palette.css".text = genPalette (
    name: value: "@define-color ${name} ${value};"
  ) c.withHashtag;

  xdg.configFile."stylix/palette.conf" = {
    enable = true;
    text = lib.concatLines [
      (genPalette (name: value: "\$${name}H = #${value}") c.withHashtag)
      (genPalette (name: value: "\$${name} = rgb(${value})") c)
    ];
  };

  xdg.configFile."stylix/palette.lua" = {
    enable = true;
    text = lib.concatLines [
      "return {"
      (genPalette (
        name: value: "${name} = \"rgba(${c."${name}-rgb-r"},${c."${name}-rgb-g"},${c."${name}-rgb-b"},1)\","
      ) c)
      "}"
    ];
  };
}
