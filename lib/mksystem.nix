# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, overlays, inputs, nixpkgs-unstable }:

platform:
{
  system,
  user,
  darwin ? false,
  wsl ? false
}:

let
  # True if this is a WSL system.
  isWSL = wsl;
  isDarwin = darwin;
  # The config files for this system.
  machineConfig = ../hosts/${platform};
  userHMConfig = ../home;
  userOSConfig = ../home/configuration/${if isDarwin then "darwin" else "nixos" };
  accountName = user.accountName;

  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;

  # Create the unstable package set
  pkgs-unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

in systemFunc rec {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    { nixpkgs.overlays = overlays; }

    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else {})

    machineConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${accountName} = { config, lib, pkgs, ... }: import userHMConfig {
              inherit config lib pkgs isWSL inputs isDarwin;
              unstable = pkgs-unstable;
              user = user;
            };
    }
    userOSConfig
    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        inherit inputs;
        currentSystem = system;
        currentSystemName = platform;
        currentSystemUser = user.accountName;
        user = user;
        isWSL = isWSL;
        isDarwin = isDarwin;
        unstable = pkgs-unstable;
        # inputs = inputs;
      };
    }
  ];
}
