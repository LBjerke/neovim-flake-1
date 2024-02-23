{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.executor-nvim;
in {
  options.vim.executor-nvim = {
    enable = mkEnableOption "Enable executor-nvim";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["executor-nvim"];
    #    vim.nnoremap = {
    #   };

    vim.luaConfigRC.harpoon = nvim.dag.entryAfter ["nui"] ''
      require("executor").setup({})
    '';
  };
}
