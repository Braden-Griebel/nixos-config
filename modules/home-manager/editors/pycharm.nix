# Pycharm nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    pycharm.enable =
      lib.mkEnableOption "Pycharm Editor";
  };

  config = lib.mkIf config.pycharm.enable {
    home.packages = with pkgs; [
      jetbrains.pycharm-community-bin
    ];
  };
}
