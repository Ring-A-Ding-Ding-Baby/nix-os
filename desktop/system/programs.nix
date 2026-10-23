{
  pkgs,
  config,
  hyprland,
  hyprPkgs,
  ...
}:
{
  programs = {
    screen.enable = true;
    uwsm.enable = true;
    wireshark.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      package = hyprPkgs.hyprland;
      portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    git = {
      enable = true;
      config.gpg.format = "ssh";
    };
    ssh = {
      startAgent = true;
      extraConfig = "
       Host github.com
	     User git 
       IdentityFile ~/.ssh/id_ed25519
      ";
    };
    zsh = {
      enable = true;
      # dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      enableBashCompletion = true;
      vteIntegration = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 1000;
      shellAliases = {
        xo = "xdg-open";
        qute = "qutebrowser --qt-flag disable-gpu &> /dev/null & disown";
        nixc = "sudo -E zsh -c 'cd /etc/nixos && exec zsh'";
        nss = "nixos-rebuild switch";
      };
      enableLsColors = true;
      promptInit = ''
        autoload -Uz vcs_info
        precmd() {vcs_info}
        zstyle ':vcs_info:git:*' formats '[%b]'
        setopt PROMPT_SUBST
        PROMPT=$'%{\e[5;3m%}%F{yellow}[%n]%f%F{blue}[%~]%f%F{green}''${vcs_info_msg_0_}%f %{\e[0m%}'
      '';
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "vi-mode"
        ];
      };
    };
  };
}
