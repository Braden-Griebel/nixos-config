# CLI Applications
{pkgs, ...}: {
  imports = [
    ./git.nix
    ./tmux.nix
  ];

  # Install desired packages
  home.packages = with pkgs; [
    csvlens
    devenv
    distrobox
    fastfetch
    silver-searcher
    uv
    wget
    wl-clipboard
  ];

  # Install QOL cli applications by default
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "bisexual";
      backend = "fastfetch";
      mode = "rgb";
      auto_detect_light_dark = true;
      light_dark = "dark";
      lightness = 0.6;
      color_align = {
        mode = "horizontal";
      };
      pride_month_disable = false;
    };
  };
  programs.lazygit.enable = true;
  programs.ripgrep.enable = true;
  programs.yazi.enable = true;
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  # Add direnv
  programs.direnv = {
    enable = true;
  };

  # Enable Lorri
  services.lorri.enable = true;
}
