{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.yazi;
  };

  xdg.configFile."yazi/yazi.toml".source  = ./yazi.toml;
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
}
