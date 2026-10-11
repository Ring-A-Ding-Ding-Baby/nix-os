{
  ...
}:
{
  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    foliate = {
      enable = true;
    };
    qutebrowser = {
      enable = true;
      loadAutoconfig = true;
    };
    neovim = {
      enable = true;
      withRuby = true;
      withPython3 = true;
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
    java.enable = true;
    gradle.enable = true;

    wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local act = wezterm.action

        config.enable_tab_bar = true 
        config.hide_tab_bar_if_only_one_tab = true
        config.keys = {
          { key = 'c', mods = 'SUPER', action = act.ActivateCopyMode },
          { key = 'w', mods = 'SUPER', action = act.SpawnWindow},
        }
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
  };
}
