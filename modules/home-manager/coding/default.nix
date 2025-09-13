# Template nix module
{lib, ...}: {
  imports = [
    ./python.nix
    ./typst.nix
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  python.enable = lib.mkDefault true;
  typst.enable = lib.mlDefault true;
}
