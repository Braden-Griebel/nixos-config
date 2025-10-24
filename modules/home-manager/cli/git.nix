# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [git];
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "bgriebel@uw.edu";
        name = "Braden Griebel";
      };
      init.defaultBranch = "main";
    };
  };
}
