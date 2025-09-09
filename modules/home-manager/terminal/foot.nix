# Foot nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    foot = {
      enable =
        lib.mkEnableOption "Foot Terminal module";
      fontFamily = lib.mkOption {
        description = "Font Family to use for Foot terminal";
        default = "FiraCode Nerd Font Mono";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "${config.foot.fontFamily}:size=12";
          dpi-aware = "yes";
          shell = lib.getExe pkgs.fish;
        };
        mouse = {
          hide-when-typing = "yes";
        };
        colors = {
          foreground = "f8f8f2";
          background = "282a36";
          regular0 = "000000"; # black
          regular1 = "ff5555"; # red
          regular2 = "50fa7b"; # green
          regular3 = "f1fa8c"; # yellow
          regular4 = "bd93f9"; # blue
          regular5 = "ff79c6"; # magenta
          regular6 = "8be9fd"; # cyan
          regular7 = "bfbfbf"; # white
          bright0 = "4d4d4d"; # bright black
          bright1 = "ff6e67"; # bright red
          bright2 = "5af78e"; # bright green
          bright3 = "f4f99d"; # bright yellow
          bright4 = "caa9fa"; # bright blue
          bright5 = "ff92d0"; # bright magenta
          bright6 = "9aedfe"; # bright cyan
          bright7 = "e6e6e6"; # bright white
          cursor = ["282a36 f8f8f2"];
        };
        csd = {
          preferred = "none";
          hide-when-maximized = "yes";
        };
      };
    };
  };
}
