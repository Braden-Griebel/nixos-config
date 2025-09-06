# Intellij IDEA module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    intellij.enable =
      lib.mkEnableOption "Intellij IDEA Editor";
  };

  config = lib.mkIf config.intellij.enable {
    home.packages = with pkgs; [
      jetbrains.idea-community-bin
    ];
  };
}
