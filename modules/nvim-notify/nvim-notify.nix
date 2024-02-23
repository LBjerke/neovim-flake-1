{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.nvim-notify;
in {
  options.vim.nvim-notify = {
    enable = mkEnableOption "Enable nvim-notify";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["nvim-notify"];
    #    vim.nnoremap = {
    #   };

    vim.luaConfigRC.harpoon = nvim.dag.entryAnywhere ''
      require("nvim-notify").setup()
    '';
  };
}
