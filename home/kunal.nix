{ home, pkgs, ... } :
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };

  home.packages = with pkgs; [
    btop
  ];

  home.stateVersion = "26.05"; # DO NOT EVER MODIFY
}
