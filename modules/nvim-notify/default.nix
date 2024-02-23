
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./nvim-notify.nix
  ];
}
