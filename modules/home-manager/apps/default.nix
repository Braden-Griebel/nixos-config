# Discord nix module
{lib, ...}: {
  imports = [
    # Can import other modules to bundle them together
    ./discord.nix
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  discord.enable = lib.mkDefault true;
}
