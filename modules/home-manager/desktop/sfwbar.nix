# Module for SFWbar
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sfwbar = {
      enable =
        lib.mkEnableOption "SFWbar Module";
      configPreset = lib.mkOption {
        default = "t2";
        description = "Choose SFWbar config type (t2, wbar, or w10)";
        type = with lib.types; str;
      };
    };
  };

  config = lib.mkIf config.sfwbar.enable {
    home.packages = with pkgs; [
      sfwbar
      python3
    ];

    xdg.configFile."sfwbar/sfwbar.config".source =
      if config.sfwbar.configPreset == "t2"
      then ./t2.config
      else
        (
          if config.sfwbar.configPreset == "wbar"
          then ./wbar.config
          else
            (
              if config.sfwbar.configPreset == "w10"
              then ./w10.config
              else ./t2.config
            )
        );
  };
}
