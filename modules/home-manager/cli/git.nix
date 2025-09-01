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
    userEmail = "bgriebel@uw.edu";
    userName = "Braden Griebel";
    extraConfig.init.defaultBranch = "main";
  };
}
