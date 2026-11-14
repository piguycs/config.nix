{ ... } :
{
  programs = {
    # the GOAT
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # need only a single text editor on my system
    nano.enable = false;
  };
}
