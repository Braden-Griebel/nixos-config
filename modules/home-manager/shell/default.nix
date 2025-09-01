# Template nix module 
{ pkgs, lib, config, ...}: {
  imports = [
    # Can import other modules to bundle them together
    ./fish.nix
  ];

  # With the imported modules can then use below to set default 
  # enabled modules
  fish.enable = lib.mkDefault true;
}
