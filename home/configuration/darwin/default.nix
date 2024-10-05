{ inputs, pkgs, user, ... }:

{
  # nixpkgs.overlays = import ../../lib/overlays.nix ++ [
  #   (import ./vim.nix { inherit inputs; })
  # ];

  # zjstatus = zjstatus.packages.${prev.system}.default;

  imports = [
    ./homebrew
    ./macOS
  ];

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.${user.accountName} = {
    home = user.homeDirectory;
    shell = pkgs.zsh;
  };

  services.nix-daemon.enable = true;
}
