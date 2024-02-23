{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.harpoon;
in {
  options.vim.harpoon = {
    enable = mkEnableOption "Enable harpoon";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["harpoon-lua"];
    vim.nnoremap = {
      "<leader>a" = ":lua require(\"harpoon.mark\").add_file()<CR>";
      "<C-e>" = ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>";
      "<C-h>" = ":lua require(\"harpoon.ui\").nav_file(1)<CR>";
      "<C-t>" = ":lua require(\"harpoon.ui\").nav_file(2)<CR>";
      "<C-n>" = ":lua require(\"harpoon.ui\").nav_file(3)<CR>";
      "<C-s>" = ":lua require(\"harpoon.ui\").nav_file(4)<CR>";
    };

    vim.luaConfigRC.harpoon = nvim.dag.entryAnywhere ''
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      require("telescope").load_extension('harpoon')
    '';
  };
}
