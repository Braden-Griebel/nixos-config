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
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      tokyo-night-tmux
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
