{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.obsidian;
in {
  options.vim.obsidian = {
    enable = mkEnableOption "Enable obsidian";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["obsidian"];
    #    vim.nnoremap = {
    #   };

    vim.luaConfigRC.harpoon = nvim.dag.entryAfter ["plenary-nvim"] ''
            require("obsidian").setup({
        "epwalsh/obsidian.nvim",
        tag = "*",
        requires = {
          "nvim-lua/plenary.nvim",

        },
            workspaces = {
              {
                name = "personal",
                path = "~/Code/Obsidian",
              }
            },

      })
    '';
  };
}
