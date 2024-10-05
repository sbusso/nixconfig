{ config, user, pkgs, ... }:
#{ user, ... }:

{
  # home-manager.users.${user.accountName} = pkgs.lib.mkMerge [
  #   ({ config, ... }: with config.lib.file; {
      xdg.configFile."aerospace".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/programs/aerospace";
  #   })
  # ];
#  home-manager.users.${user.accountName}.xdg.configFile."aerospace".source = ./.;
}
