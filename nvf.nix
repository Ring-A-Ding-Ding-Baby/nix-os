{...}: {
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        autocomplete = {
          blink-cmp.enable = true;
          blink-cmp.setupOpts.signature.enabled = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          lightbulb.autocmd.enable = true;
          inlayHints.enable = true;
          lspkind.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;

          enableDAP = true;
          rust.enable = true;
          nix.enable = true;
          nix.lsp.server = "nixd";
        };
        options = {
          autoindent = true;
        };
        binds = {
          whichKey.enable = true;
        };
        telescope = {
          enable = true;
        };
        ui = {
          breadcrumbs.enable = true;
          colorizer.enable = true;
        };
        visuals = {
          indent-blankline.enable = true;
        };
        statusline.lualine.enable = true;
        git.enable = true;
      };
    };
  };
}
