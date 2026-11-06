{
  description = "My NixOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mikuPlymouth = {
      url = "github:Thang1191/MikuPlymouth";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, mikuPlymouth, ... }: {
    nixosConfigurations.nix-test-vm = nixpkgs.lib.nixosSystem {
      modules = [
        disko.nixosModules.disko
        mikuPlymouth.nixosModules.default
        ./hosts/nix-test-vm
      ];
    };
  };
}
