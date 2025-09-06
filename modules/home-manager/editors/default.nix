# Bundle editor configs
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./vscode.nix
  ];

  # With the imported modules can then use below to set default
  # enabled modules
}
