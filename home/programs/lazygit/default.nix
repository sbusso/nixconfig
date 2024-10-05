{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
    settings = {};
  };

  xdg.configFile."lazygit/config.yml".source = ./config.yml;
}
