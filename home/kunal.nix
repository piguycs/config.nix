{ home, pkgs, ... } :
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
      initLua = builtins.readFile ./nvim.lua;
    };

    ghostty = {
      enable = true;
      settings = {
        theme = "Kanagawa Wave";
        window-theme = "ghostty";
        font-family = "Iosevka Nerd Font";
        font-size = 15;
      };
    };

    keepassxc = {
      enable = true;
      autostart = true;
    };

    starship = {
      enable = true;
    };

    fish = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
        { package = appindicator; }
      ];
    };
  };

  xdg.autostart.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.iosevka
    # general tools which I use
    btop
  ];

  home.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
