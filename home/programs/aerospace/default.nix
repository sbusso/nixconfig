{ config, user, pkgs, ... }:
#{ user, ... }:

{
  # home-manager.users.${user.accountName} = pkgs.lib.mkMerge [
  #   ({ config, ... }: with config.lib.file; {
      xdg.configFile."aerospace.toml".source = ./aerospace.toml;
  #   })
  # ];
#  home-manager.users.${user.accountName}.xdg.configFile."aerospace".source = ./.;
}
