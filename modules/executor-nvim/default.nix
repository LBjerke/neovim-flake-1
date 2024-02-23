{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./executor-nvim.nix
  ];
}
