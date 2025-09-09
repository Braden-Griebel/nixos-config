# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Can import other modules to bundle them together
    ./alacritty.nix
    ./foot.nix
  ];

  # Install desired fonts
  home.packages = with pkgs.nerd-fonts; [
    fira-code
    bigblue-terminal
    departure-mono
    comic-shanns-mono
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  alacritty.enable = lib.mkDefault true;
  alacritty.fontFamily = "FiraCode Nerd Font Mono";
  foot.enable = lib.mkDefault true;
  foot.fontFamily = "FiraCode Nerd Font Mono";
}
