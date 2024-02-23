{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
in {
  options.vim.lsp = {
    lsp-lines = {
      enable = mkEnableOption "lsp signature viewer";
    };
  };

  config = mkIf (cfg.enable && cfg.lspSignature.enable) {
    vim.startPlugins = ["lsp-lines"];

    vim.luaConfigRC.lsp-lines = nvim.dag.entryAfter ["nvim-lspconfig"] ''
       -- Enable lsp-lines
       require("lsp_lines").setup()
      vim.diagnostic.config({
       virtual_text = false,
      })

    '';
  };
}
