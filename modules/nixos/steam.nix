# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    steam.enable =
      lib.mkEnableOption "Steam module";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
    programs.java.enable = true;
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
    environment.systemPackages = with pkgs; [
      steam-run
    ];
  };
}
