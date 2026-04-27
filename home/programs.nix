{pkgs, config, nur, ...}: let
  nurpkgs = nur.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  firefox-addons = nurpkgs.repos.rycee.firefox-addons;
  home = config.users.users.shrimp.home;
in{
  programs = {
    git = {
      enable = true;
      settings.user.email = "ebachvictor@gmail.com";
      settings.user.name = "Ring-A-Ding-Ding-Baby";
      settings.pull.rebase = true;
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
        return {
          enable_tab_bar = false,
        }'';
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
	  packages = with firefox-addons; [
	    vimium 
	  ];
	  settings = {
	    vimium = {
	      settings = {
	       permissions = ["tabs" "bookmarks" "clipboardWrite" "clipboardRead" "history" "notifications" "webNavigation"];
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

    java.enable = true;
  };
}
