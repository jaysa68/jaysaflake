{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";

    plugins = {
      treesitter.enable = true;
      lualine.enable = true;
      gitsigns.enable = true;
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
	  nil_ls.enable = true; #nix (SO USEFUL OMG)
	  pyright.enable = true; #python
	  ts_ls.enable = true; #typescript
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
