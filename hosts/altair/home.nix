{
  config,
  pkgs,
  inputs,
  system,
  desktopSettings,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bgriebel";
  home.homeDirectory = "/home/bgriebel";

  imports = [
    ../../modules/home-manager/apps
    ../../modules/home-manager/cli
    ../../modules/home-manager/coding
    ../../modules/home-manager/desktop
    ../../modules/home-manager/editors
    ../../modules/home-manager/terminal
    ../../modules/home-manager/shell
    ../../modules/home-manager/unfree.nix
  ];

  niri.enable = desktopSettings.niri.enable;
  hyprland.enable = desktopSettings.hyprland.enable;

  # Enable vscode
  vscode.enable = true;

  # Enable intellij and pycharm
  intellij.enable = true;
  pycharm.enable = true;

  # Enable Ghidra
  ghidra.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    inputs.panthervim.packages.${system}.default
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager Manage Fonts
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
