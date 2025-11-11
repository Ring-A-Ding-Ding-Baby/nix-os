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
        treesitter.indent.disable = ["nix"];
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
          rust = {
            enable = true;
            crates.enable = true;
            dap.enable = false;
          };
          python.enable = true;
          nix.enable = true;
          nix.lsp.server = "nixd";
        };
        options = {
          autoindent = true;
        };
        binds = {
          whichKey.enable = true;
        };
        keymaps = [
          {
            key = "<leader>e";
            desc = "Neo-Tree";
            mode = "n";
            action = "<cmd>Neotree action=focus source=filesystem position=float toggle=true<CR>";
          }
        ];
        telescope = {
          enable = true;
        };
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            enable_cursor_hijack = true;
            auto_clean_after_session_restore = true;
            git_status-async = true;
          };
        };
        tabline.nvimBufferline = {
          enable = true;
          setupOpts.options.indicator.style = "none";
          mappings = {
            closeCurrent = "<leader>bx";
            cycleNext = "<tab>";
            cyclePrevious = "<S-tab>";
          };
        };
        utility = {
          smart-splits = {
            enable = true;
          };
        };
        debugger = {
          nvim-dap = {
            enable = true;
            ui = {
              enable = true;
              autoStart = true;
            };
          };
        };
        ui = {
          borders.enable = false;
          borders.globalStyle = "none";
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
