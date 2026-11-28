{ config, pkgs, lib, ... } :
let
  cfg = config.dots.gnome;
in
{
  options.dots.gnome = {
    enable = lib.mkEnableOption "GNOME desktop";
    useGhostty = lib.mkEnableOption "Replace gnome-console with ghostty";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
    })

    (lib.mkIf cfg.useGhostty {
      xdg.terminal-exec = {
        enable = true;
        settings.default = [ "com.mitchellh.ghostty.desktop" ];
      };

      environment = {
        gnome.excludePackages = with pkgs; [ gnome-console ];
        systemPackages = with pkgs; [ ghostty ];
      };
    })
  ];
}
