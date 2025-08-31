# CLI Applications
{ pkgs, lib, config, ...}: {
  imports = [
    ./git.nix
  ];

  # Install desired packages 
  home.packages = with pkgs; [
    bat
    csvlens
    eza
    fd
    fzf
    gh
    git
    lazygit
    ripgrep
    silver-searcher
    yazi
    zoxide
    vim
  ];
  
  # Install QOL cli applications by default
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}
