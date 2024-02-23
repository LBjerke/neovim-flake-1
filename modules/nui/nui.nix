{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.nui;
in {
  options.vim.nui = {
    enable = mkEnableOption "Enable nui";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["nui"];
    #    vim.nnoremap = {
    #   };

    vim.luaConfigRC.nui =
      nvim.dag.entryAnywhere ''
      '';
  };
}
