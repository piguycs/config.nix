{ pkgs, ... }:
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

  boot = {
    #plymouth = {
    #  enable = true;
    #  theme = "fade-in";
    #};
    plymouth = {
      enable = true;
      themePackages = [ pkgs.mikuPlymouth ];
      theme = "MikuPlymouth";
    };

    consoleLogLevel = 3;
    kernelParams = [ "quiet" ];
  };

  services.openssh.enable = true;
 
  system.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
