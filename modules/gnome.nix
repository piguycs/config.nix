{ pkgs, ... } :
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "com.mitchellh.ghostty.desktop" ];
    };
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-console
    ];

    systemPackages = with pkgs; [
      ghostty
    ];
  };
}
