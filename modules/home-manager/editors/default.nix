# Bundle editor configs
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./zed.nix
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  zed.enable = lib.mkDefault true;
}
