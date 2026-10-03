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
    extraGroups = [ "wheel" "networkmanager" ]
  };

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  security.sudo.wheelNeedsPassword = true;
}
