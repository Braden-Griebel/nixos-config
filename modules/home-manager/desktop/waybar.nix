# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    waybar.enable =
      lib.mkEnableOption "waybar module";
  };

  config = lib.mkIf config.waybar.enable {
    home.packages = with pkgs; [
      nerd-fonts.fira-code
      font-awesome
      btop
      swaynotificationcenter
      pavucontrol
    ];
    programs.waybar = {
      enable = true;
    };
    programs.cava = {
      enable = true;
    };
    xdg.configFile."waybar" = {
      source = ./waybar_config;
    };
  };
}
