# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord.enable =
      lib.mkEnableOption "Discord module";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
