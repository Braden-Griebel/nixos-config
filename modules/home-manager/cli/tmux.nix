{
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.bash;
    mouse = true;
    escapeTime = 1;
    baseIndex = 1;
    keyMode = "vi";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];
    extraConfig = ''
      # Set true color
      # set -g default-terminal "alacritty-256color"
      # set -as terminal-features ",xterm-256color:Tc"
      # set-option -ga terminal-overrides ",xterm-256color:Tc"

      ## enable undercurl
      # https://github.com/AstroNvim/AstroNvim/issues/1336#issuecomment-1317609457
      set -g default-terminal "alacritty"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      ## color correction
      # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour
      set -as terminal-features ",alacritty*:RGB"
      set -as terminal-overrides ",alacritty*:Tc"
      set -as terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q' # pipe cursor in vim insert mode

      # Source the rose-pine theme
      run-shell "bash $HOME/.config/tmux/plugins/rose-pine-tmux.tmux"

      # Set the shell to fish now that plugins have used bash
      set -g default-shell ${lib.getExe pkgs.fish}
    '';
  };

  xdg.configFile."tmux/plugins/rose-pine-tmux.tmux".text = ''
    #! ${lib.getExe pkgs.bash}

    base="#191724"
    surface="#1f1d2e"
    overlay="#26233a"
    muted="#6e6a86"
    subtle="#908caa"
    text="#e0def4"
    love="#eb6f92"
    gold="#f6c177"
    rose="#ebbcba"
    pine="#31748f"
    foam="#9ccfd8"
    iris="#c4a7e7"
    highlight_low="#21202e"
    highlight_med="#403d52"
    highlight_high="#524f67"

    get() {
       local option=$1
       local default_value=$2
       local option_value="$(tmux show-option -gqv "$option")"
       if [ -z "$option_value" ]; then
          echo "$default_value"
       else
          echo "$option_value"
       fi
    }

    set() {
       local option=$1
       local value=$2
       tmux set-option -gq "$option" "$value"
    }

    setw() {
       local option=$1
       local value=$2
       tmux set-window-option -gq "$option" "$value"
    }

    # Status
    set "status" "on"
    set "monitor-activity" "on"
    set "status-justify" "left"
    set "status-position" "bottom"
    set "status-left-length" "100"
    set "status-right-length" "100"
    set "status-style" "fg=$iris,bg=$base,bold"

    rosepine_time_format=$(get "@time_format" "%R")
    rosepine_date_format=$(get "@date_format" "%d/%m/%Y")

    datetime_block="#[fg=$gold,bg=$base] ''${rosepine_time_format} ''${rosepine_date_format}"
    host_block="#[fg=$iris,bg=$base] #h "
    set "status-right" "''${datetime_block} ''${host_block}"
    set "status-left" "#[fg=$iris,bg=$base] #S "

    setw "window-status-separator" ""
    setw "window-status-style" "fg=$rose,bg=$base"
    setw "window-status-current-style" "fg=$love,bg=$base"
    setw "window-status-activity-style" "fg=$base,bg=$rose"
    set "window-status-format" "#[fg=$rose,bg=$base] #I: #W "
    set "window-status-current-format" "#[fg=$love,bg=$base] #I: #W "

    # Pane
    set "pane-border-style" "fg=$highlight_low"
    set "pane-active-border-style" "fg=$highlight_high"
    set "display-panes-colour" "$text"
    set "display-panes-active-colour" "$gold"

    # Message
    set "message-style" "fg=$base,bg=$gold"
    set "message-command-style" "fg=$base,bg=$gold"
  '';
}
