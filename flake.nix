{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    panthervim = {
      url = "github:Braden-Griebel/Panthervim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      altair = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          system = system;
        };
        modules = [
          ./hosts/altair/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
