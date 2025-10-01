# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ghidra.enable =
      lib.mkEnableOption "Ghidra Reverse Engineering Framework";
  };

  config = lib.mkIf config.ghidra.enable {
    home.packages = with pkgs; [
      ghidra-bin
    ];
  };
}
