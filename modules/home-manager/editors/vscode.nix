{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
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
}
