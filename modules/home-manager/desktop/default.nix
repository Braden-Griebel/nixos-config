# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Can import other modules to bundle them together
    ./niri.nix
    ./hyprland.nix
  ];

  home.file = {
    "Pictures/desktop-wallpapers" = {
      source = ../../../wallpapers;
    };
  };
}
