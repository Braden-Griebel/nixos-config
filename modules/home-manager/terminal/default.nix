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
    _3270
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  alacritty.enable = lib.mkDefault true;
  alacritty.fontFamily = "FiraCode Nerd Font Mono";
  foot.enable = lib.mkDefault true;
  foot.fontFamily = "ComicShannsMono Nerd Font Mono"; #"3270 Nerd Font Mono";
}
