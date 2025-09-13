# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    python.enable =
      lib.mkEnableOption "Python Module";
  };

  config = lib.mkIf config.python.enable {
    home.packages = with pkgs; [
      uv
      python3
    ];
  };
}
