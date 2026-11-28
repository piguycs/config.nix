{ inputs, pkgs, ... } :
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series3
    ./hardware-configuration.nix

    ../../modules/home-manager.nix

    ../../modules/commonNew.nix
    ../../modules/timezone.nix
    ../../modules/networking.nix
    ../../modules/firefox.nix
    ../../modules/editor.nix
    ../../modules/gnome.nix
  ];

  networking.hostName = "enma";

  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    consoleLogLevel = 3;

    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    resumeDevice = "/dev/mapper/luks-be1fe8a0-eeca-4e32-b45c-257eb5a0be8f";

    initrd = {
      kernelModules = [ "xe" ];

      luks.devices."luks-be1fe8a0-eeca-4e32-b45c-257eb5a0be8f".device =
        "/dev/disk/by-uuid/be1fe8a0-eeca-4e32-b45c-257eb5a0be8f";
    };
  };

  # ---- everything below this line should probably be modified to be separate ----
  # it is currently being directly copied from the configuration, so it has
  # gnome and other stuff I may not use

  services.fprintd.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kunal = {
    isNormalUser = true;
    description = "Kunal";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    file

    keepassxc # weird thing with polkit rules file, so HM alone is not enough
  ];

  dots = {
    gnome.enable = true;
    gnome.useGhostty = true;
  };

  system.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
