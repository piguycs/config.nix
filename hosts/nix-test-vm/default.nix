{ ... }:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "nix-test-vm";
  networking.networkmanager.enable = true;

  # UEFI systemd-boot setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;

  system.stateVersion = "26.05";
}
