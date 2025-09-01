# Template nix module 
{ pkgs, lib, config, ...}: {
  imports = [
    # Can import other modules to bundle them together
  ];

  # With the imported modules can then use below to set default 
  # enabled modules
  # module1.enable = lib.mkDefault true;

  options = {
    niri.enable = 
      lib.mkEnableOption "enables niri module";
  };

  config = lib.mkIf config.niri.enable {
    # Install additional packages for niri
    home.packages = with pkgs; [
      niri
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
