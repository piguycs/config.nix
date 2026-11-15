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
      };
    };
  };

  home.packages = with pkgs; [
    btop
  ];

  home.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
