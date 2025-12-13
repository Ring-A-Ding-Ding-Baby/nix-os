{
  inputs,
  codelldb,
  ...
}: let
  dag = inputs.nvf.lib.nvim.dag;
in {
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        globals.editorconfig = true;
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
          trouble.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableDAP = true;
          java.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          python.enable = true;
          nix.enable = true;
          nix.lsp.server = "nixd";
          markdown.enable = true;
        };
        options = {
          autoindent = true;
        };
        binds = {
          whichKey = {
            enable = true;
          };
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
          setupOpts = {
            defaults.color_devicons = true;
          };
        };
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            enable_cursor_hijack = true;
            auto_clean_after_session_restore = true;
            git_status-async = true;
            window.position = "float";
            #window.popup.border.style = "none";
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
          surround.enable = true;
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
        mini.jump2d.enable = true;
        ui = {
          illuminate.enable = true;
          borders.enable = false;
          borders.globalStyle = "none";
          breadcrumbs.enable = true;
          colorizer.enable = true;
        };
        visuals = {
          indent-blankline.enable = true;
          rainbow-delimiters.enable = true;
          nvim-web-devicons.enable = true;
        };
        statusline.lualine.enable = true;
        git = {
          enable = true;
          gitsigns = {
          };
          neogit = {
            enable = true;
          };
        };
        terminal = {
          toggleterm.enable = true;
        };
        pluginRC.dap-signs = dag.entryAfter ["nvim-dap"] ''
          vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DiagnosticSignError'})
          vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn'})
          vim.fn.sign_define('DapBreakpointRejected',  { text = '', texthl = 'DiagnosticSignHint'})
          vim.fn.sign_define('DapLogPoint',            { text = '', texthl = 'DiagnosticSignInfo'})
          vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DiagnosticSignInfo'})
          vim.api.nvim_set_hl(0, 'DapStoppedLine', { link = 'Visual' })
        '';
      };
    };
  };
}
