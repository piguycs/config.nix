{
  description = "My NixOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations = {
      nix-test-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nix-test-vm
        ];
      };

      enma = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/enma
	  nixos-hardware.nixosModules.framework-intel-core-ultra-series3
        ];
      };
    };
  };
}
