{ pkgs, ... }:

{
  home.packages = [ pkgs.silicon ];

  xdg.configFile."silicon/config".source = ./config;
}
