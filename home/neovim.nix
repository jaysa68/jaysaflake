{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "File tree";
      }
    ];
    plugins = {
      treesitter.enable = true;
      lualine.enable = true;
      neo-tree = {
        enable = true;
      };
      gitsigns = {
        enable = true;
        settings = {
          on_attach.__raw = ''
            function(bufnr)
              local gitsigns = require('gitsigns')

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              -- Navigation
              map('n', ']c', function()
                if vim.wo.diff then
                  vim.cmd.normal({']c', bang = true})
                else
                  gitsigns.nav_hunk('next')
                end
              end)

              map('n', '[c', function()
                if vim.wo.diff then
                  vim.cmd.normal({'[c', bang = true})
                else
                  gitsigns.nav_hunk('prev')
                end
              end)

              -- Actions
              map('n', '<leader>hs', gitsigns.stage_hunk)
              map('n', '<leader>hr', gitsigns.reset_hunk)
              map('v', '<leader>hs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
              end)
              map('v', '<leader>hr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
              end)
              map('n', '<leader>hS', gitsigns.stage_buffer)
              map('n', '<leader>hR', gitsigns.reset_buffer)
              map('n', '<leader>hp', gitsigns.preview_hunk)
              map('n', '<leader>hi', gitsigns.preview_hunk_inline)
              map('n', '<leader>hb', function()
                gitsigns.blame_line({ full = true })
              end)
              map('n', '<leader>hd', gitsigns.diffthis)
              map('n', '<leader>hD', function()
                gitsigns.diffthis('~')
              end)
              map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
              map('n', '<leader>hq', gitsigns.setqflist)

              -- Toggles
              map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
              map('n', '<leader>tw', gitsigns.toggle_word_diff)

              -- Text object
              map({'o', 'x'}, 'ih', gitsigns.select_hunk)
            end
          '';
        };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";
          "<leader>fr" = "lsp_references";
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # nix (SO USEFUL OMG)
          pyright.enable = true; # python
          ts_ls.enable = true; # typescript
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          tailwindcss.enable = true;
        };
      };
      cmp.enable = true;
    };

    opts = {
      termguicolors = true; # full 256 color set or whatever
      number = true; # line number
    };
    extraPlugins = [ pkgs.vimPlugins.melange-nvim ];
    colorscheme = "melange";
  };
}
