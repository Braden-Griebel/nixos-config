# Nix Module for Configuring Desktop
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktopSettings.niri.enable =
      lib.mkEnableOption "niri wm based desktop environment";
  };

  config = {}; 
}
