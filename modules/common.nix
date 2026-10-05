{ pkgs, lib, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  users.users.kunal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nano.enable = false;

    niri = {
      enable = true;
    };
  };

  services.displayManager = {
    defaultSession = "niri";
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${lib.getExe pkgs.tuigreet}";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  security = {
    sudo-rs = {
      enable = true;
    };
  };

  security.sudo.wheelNeedsPassword = true;
}
