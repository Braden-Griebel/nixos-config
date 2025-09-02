# Nix module for zed editor
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zed.enable =
      lib.mkEnableOption "Zed editor home-manager module";
  };

  config = lib.mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        minimap = {show = "auto";};
        inlay_hints = {
          enabled = true;
          show_value_hints = true;
          show_type_hints = true;
          show_parameter_hints = true;
          show_other_hints = true;
          show_background = false;
          edit_debounce_ms = 700;
          scroll_debounce_ms = 50;
          toggle_on_modifiers_press = {
            control = false;
            alt = false;
            shift = false;
            platform = false;
            function = false;
          };
        };
        "buffer_font_family" = "FiraCode Nerd Font Mono";
        "ui_font_family" = "Zed Plex Sans";
        "disable_ai" = true;
        "icon_theme" = "Zed (Default)";
        "vim_mode" = true;
        "ui_font_size" = 16;
        "buffer_font_size" = 16;
        "theme" = {
          "mode" = "dark";
          "light" = "Ayu Light";
          "dark" = "One Dark";
        };
      };
    };
  };
}
