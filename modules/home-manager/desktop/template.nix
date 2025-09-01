# Template nix module 
{ pkgs, lib, config, ...}: {
  imports = [
    # Can import other modules to bundle them together
  ];

  # With the imported modules can then use below to set default 
  # enabled modules
  # module1.enable = lib.mkDefault true;

  options = {
    # template.enable = 
    #   lib.mkEnableOption "enables template module";
  };

  config = {}; #lib.mkIf config.template.enable {
  # };
}
