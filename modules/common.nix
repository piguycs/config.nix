{ pkgs, ... }:

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
