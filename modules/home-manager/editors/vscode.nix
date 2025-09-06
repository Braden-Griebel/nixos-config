# VSCode nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vscode.enable =
      lib.mkEnableOption "VSCode module with some default extensions";
  };

  config = lib.mkIf config.template.enable {
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        golang.go
        ms-python.python
        ms-python.mypy-type-checker
        charliermarsh.ruff
        rust-lang.rust-analyzer
        reditorsupport.r
        ms-toolsai.jupyter
        llvm-vs-code-extensions.vscode-clangd
        llvm-vs-code-extensions.lldb-dap
        ocamllabs.ocaml-platform
        arrterian.nix-env-selector
        mkhl.direnv
      ];
    };
  };
}
