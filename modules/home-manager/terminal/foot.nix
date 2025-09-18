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
          background = "191724";
          foreground = "e0def4";

          regular0 = "26233a"; # black (Overlay)
          regular1 = "eb6f92"; # red (Love)
          regular2 = "9ccfd8"; # green (Foam)
          regular3 = "f6c177"; # yellow (Gold)
          regular4 = "31748f"; # blue (Pine)
          regular5 = "c4a7e7"; # magenta (Iris)
          regular6 = "ebbcba"; # cyan (Rose)
          regular7 = "e0def4"; # white (Text)

          bright0 = "47435d"; # bright black (lighter Overlay)
          bright1 = "ff98ba"; # bright red (lighter Love)
          bright2 = "c5f9ff"; # bright green (lighter Foam)
          bright3 = "ffeb9e"; # bright yellow (lighter Gold)
          bright4 = "5b9ab7"; # bright blue (lighter Pine)
          bright5 = "eed0ff"; # bright magenta (lighter Iris)
          bright6 = "ffe5e3"; # bright cyan (lighter Rose)
          bright7 = "fefcff"; # bright white (lighter Text)

          flash = "f6c177"; # yellow (Gold)

          cursor = ["191724" "e0def4"];
        };
        csd = {
          preferred = "server";
          hide-when-maximized = "yes";
        };
      };
    };
  };
}
