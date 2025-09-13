# Typst nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    typst.enable =
      lib.mkEnableOption "Typst Module";
  };

  config = lib.mkIf config.typst.enable {
    home.packages = with pkgs; [typst];
  };
}
