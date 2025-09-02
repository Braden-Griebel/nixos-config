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
    desktopSettings.hyprland.enable =
      lib.mkEnableOption "hyprland wm based desktop environment";
    desktopSettings.gnome.enable =
      lib.mkEnableOption "gnome desktop environment";
    desktopSettings.kde.enable =
      lib.mkEnableOption "plasma desktop environment";
  };

  config = {};
}
