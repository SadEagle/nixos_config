{ ... }:
{
  xgd.configFile."nvim".source = "../nvim";
  programs.neovim = {
    enable = true;
  };
}
