{pkgs, ...}: let
in {
  stylix = {
    enable = true;
    base16Scheme = {
      # backgrounds
      base00 = "#070c0f"; # deep cold abyss
      base01 = "#0f181d"; # slate night
      base02 = "#172328"; # charcoal blue

      # comments / inactive
      base03 = "#4a4468"; # cosmic fog violet (comments)
      base04 = "#33474f"; # borders / muted ui

      base05 = "#c7d6dc";
      base06 = "#9fb2bb";
      base07 = "#f2feff";

      # error
      base08 = "#5446a6"; # void indigo
      # urgent
      base09 = "#8a7dff"; # deep cosmic violet
      # warning
      base0A = "#6f66d4"; # arcane purple
      # success
      base0B = "#5c8fd6"; # calm cobalt
      # info
      base0C = "#70c6ff"; # ice cyan
      # primary / focus
      base0D = "#7aa6ff"; # periwinkle focus
      # secondary accent
      base0E = "#a49adf"; # lavender steel
      # tertiary
      base0F = "#86a8d6"; # nebula blue

      # Extra Base24 (brights, still cold & foggy)
      base10 = "#0b1216";
      base11 = "#040809";
      base12 = "#6a5cd0"; # bright error (still cold)
      base13 = "#8f86e6"; # bright warning
      base14 = "#78a6e6"; # bright success
      base15 = "#96d4ff"; # bright info
      base16 = "#b2bdfc"; # bright primary
      base17 = "#ffffff";
    };

    autoEnable = true;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
      };
      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka Aile";
      };
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka Etoile";
      };
      sizes = {
        desktop = 10;
        applications = 10;
        terminal = 10;
      };
    };
  };
}
