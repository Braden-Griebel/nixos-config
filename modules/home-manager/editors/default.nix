# Bundle editor configs
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./vscode.nix
    ./intellij.nix
    ./pycharm.nix
  ];
}
