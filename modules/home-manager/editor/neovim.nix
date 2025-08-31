# Template nix module 
{ pkgs, lib, config, ...}: {
  options = {
    neovim.enable = 
      lib.mkEnableOption "enables neovim module";
  };

  config = lib.mkIf config.neovim.enable {
    programs.nvf = {
      enable=true;
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "dark";
        };
        languages = {
          nix.enable = true;
        };
      };
    };
  };
}
