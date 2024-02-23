{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.noice;
in {
  options.vim.noice = {
    enable = mkEnableOption "Enable noice";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["noice"];
    #vim.nnoremap = {
    #};

    vim.luaConfigRC.harpoon = nvim.dag.entryAfter ["nvim-notify" "nui" "nvim-cmp"] ''
      require("noice").setup({     })
    '';
  };
}
