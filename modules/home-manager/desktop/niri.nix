# Niri nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Can import other modules to bundle them together
    ./sfwbar.nix
  ];

  options = {
    niri.enable =
      lib.mkEnableOption "niri home-manager module";
  };

  config = lib.mkIf config.niri.enable {
    # Enable the waybar niri module by default
    sfwbar.enable = lib.mkDefault true;
    sfwbar.configPreset = lib.mkDefault "t2";

    # Add niri modules to the waybar config
    waybar.niri = true;

    # Install additional packages for niri
    home.packages = with pkgs; [
      swaybg
    ];

    # Enable programs used by niri
    programs = {
      fuzzel.enable = true;
      swaylock.enable = true;
    };
    # Enable services used by niri
    services = {
      mako.enable = true;
      swayidle.enable = true;
      polkit-gnome.enable = true;
    };

    # Setup the niri config file
    xdg.configFile."niri/config.kdl".source = ./niri_config.kdl;
  };
}
