{
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.fish;
    mouse = true;
    escapeTime = 1;
    baseIndex = 1;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      dracula
      yank
      tmux-which-key
    ];
    extraConfig = ''
      # Set true color
      set -g default-terminal "tmux-256color"
      set -as terminal-features ",xterm-256color:Tc"
    '';
  };
}
