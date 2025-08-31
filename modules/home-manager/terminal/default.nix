# Template nix module 
{ pkgs, lib, config, ...}: {
  imports = [
    # Can import other modules to bundle them together
    ./alacritty.nix
  ];

  # For all the terminals, need to install FiraCode Nerd Font
  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # With the imported modules can then use below to set default 
  # enabled modules
  alacritty.enable = lib.mkDefault true;
}
