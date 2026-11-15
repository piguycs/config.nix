{
  description = "My NixOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, ... }: {
    nixosConfigurations = {
      nix-test-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nix-test-vm
        ];
      };

      enma = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit inputs; };
        modules = [ ./hosts/enma ];
      };
    };
  };
}
