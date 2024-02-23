{
  pkgs,
  lib,
  check ? true,
}: let
  modules = [
    ./harpoon
    ./obsidian
    ./executor-nvim
    ./completion
    ./theme
    ./core
    ./basic
    ./nui
    ./statusline
    ./tabline
    ./filetree
    ./nvim-notify
    ./visuals
    ./noice
    ./lsp
    ./languages
    ./treesitter
    ./autopairs
    ./snippets
    ./keys
    ./telescope
    ./git
    ./build
  ];

  pkgsModule = {config, ...}: {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
      _module.check = check;
    };
  };
in
  modules ++ [pkgsModule]
