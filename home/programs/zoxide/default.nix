{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.zoxide;
#    options = [ "--cmd cd" ];
  };
}
