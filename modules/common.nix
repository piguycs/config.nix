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

    nano.enable = false;

    niri = {
      enable = true;
    };
  };

  services.displayManager = {
    plasma-login-manager.enable = true;
    defaultSession = "niri";
  };

  environment.systemPackages = with pkgs; [
    git
    tmux
  ];

  security = {
    sudo-rs = {
      enable = true;
    };
  };

  security.sudo.wheelNeedsPassword = true;

  systemd.tmpfiles.rules = [
    "d /var/lib/plasmalogin/.config 0755 plasmalogin plasmalogin -"
    "L+ /var/lib/plasmalogin/.config/kdeglobals - - - - ${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"
  ];
}
