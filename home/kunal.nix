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
        font-family = "Iosevka Nerd Font Mono";
        font-size = 15;
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.iosevka
    # general tools which I use
    btop
  ];

  home.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
