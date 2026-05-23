{
  pkgs,
  nur,
  ...
}:
let
  nurpkgs = nur.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs = {
    neovim = {
      enable = true;
      withRuby = false;
      withPython3 = false;
      extraLuaPackages =
        ps: with ps; [
          (pkgs.luajitPackages.callPackage ../lua-curl.nix { })
          (pkgs.luajitPackages.callPackage ../lunajson.nix { })
        ];
      initLua = ''
        require('config.lazy')
      '';
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "ebachvictor@gmail.com";
          name = "Ring-A-Ding-Ding-Baby";
        };
        pull.rebase = true;
      };
    };
    diff-highlight = {
      enable = true;
      enableGitIntegration = true;
    };
    gpg.enable = true;
    home-manager.enable = true;

    wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = wezterm.config_builder()
        local act = wezterm.action

        config.enable_tab_bar = false
        config.debug_key_events = true
        config.keys = {
          { key = 'c', mods = 'SUPER', action = act.ActivateCopyMode },
        }

        return config
      '';
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    hyprlock = {
      enable = true;
    };

    wlogout.enable = true;

    librewolf = {
      enable = true;
      profiles.detective_shrimp = {
        settings.extensions.autoDisableScopes = 0;
        extensions = {
          force = true;
          packages = with nurpkgs.repos.rycee.firefox-addons; [
            vimium
          ];
          settings = {
            vimium = {
              settings = {
                permissions = [
                  "tabs"
                  "bookmarks"
                  "clipboardWrite"
                  "clipboardRead"
                  "history"
                  "notifications"
                  "webNavigation"
                ];
                grabBackFocus = true;
                hideUpdateNotifications = true;
                ignoreKeyboardLayout = true;
                settingsVersion = "2.4.2";
              };
            };
          };
        };
      };
    };
  };
}
