# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
  # Link the yazi flavor directory
  xdg.configFile."yazi/flavors/rose-pine.yazi" = {
    source = ./rose-pine.yazi;
  };
  # Set the yazi theme
  xdg.configFile."yazi/theme.toml" = {
    text = ''
      [flavor]
      dark = "rose-pine"
    '';
  };
}
