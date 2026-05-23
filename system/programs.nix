{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    uwsm = {
      enable = true;
    };
    hyprland =
      let
        hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        withUWSM = true;
        package = hypr-pkgs.hyprland;
        portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
      };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    git = {
      enable = true;
      config = {
        gpg = {
          format = "ssh";
        };
      };
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
      enableCompletion = true;
      enableBashCompletion = true;
      vteIntegration = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 1000;
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
