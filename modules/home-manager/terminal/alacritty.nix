# Alacritty nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alacritty = {
      enable =
        lib.mkEnableOption "Alacritty module";
      fontFamily = lib.mkOption {
        description = "Font Family to use for Alacritty terminal";
        default = "FiraCode Nerd Font Mono";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.alacritty.enable {
    home.packages = with pkgs; [alacritty];
    programs.alacritty.enable = true;
    programs.alacritty.settings = {
      font = {
        normal = {
          family = config.alacritty.fontFamily;
          style = "Regular";
        };
        bold = {
          family = config.alacritty.fontFamily;
          style = "Bold";
        };
        italic = {
          family = config.alacritty.fontFamily;
          style = "Italic";
        };
        bold_italic = {
          family = config.alacritty.fontFamily;
          style = "Bold Italic";
        };
        size = 14;
      };
      terminal = {shell = "fish";};
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
          bright_foreground = "#ffffff";
        };
        cursor = {
          text = "#282a36";
          cursor = "#f8f8f2";
        };
        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        selection = {
          text = "CellForeground";
          background = "#44475a";
        };
        normal = {
          black = "#21222c";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#f8f8f2";
        };
        bright = {
          black = "#6272a4";
          red = "#ff6e6e";
          green = "#69ff94";
          yellow = "#ffffa5";
          blue = "#d6acff";
          magenta = "#ff92df";
          cyan = "#a4ffff";
          white = "#ffffff";
        };
        search.matches = {
          foreground = "#44475a";
          background = "#50fa7b";
        };
        search.focused_match = {
          foreground = "#44475a";
          background = "#ffb86c";
        };
        footer_bar = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        hints.start = {
          foreground = "#282a36";
          background = "#f1fa8c";
        };
        hints.end = {
          foreground = "#f1fa8c";
          background = "#282a36";
        };
      };
    };
  };
}
