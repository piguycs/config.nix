{
  description = "My NixOS machines";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.nix-test-vm = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/nix-test-vm ];
    };
  };
}
