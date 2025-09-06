# CLI Applications
{pkgs, ...}: {
  imports = [
    ./git.nix
    ./tmux.nix
  ];

  # Install desired packages
  home.packages = with pkgs; [
    csvlens
    distrobox
    fastfetch
    silver-searcher
    wget
    wl-clipboard
  ];

  # Install QOL cli applications by default
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
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
