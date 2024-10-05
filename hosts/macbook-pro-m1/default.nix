{ config, pkgs, user, ... }:

# TODO: inherit user from flake

{

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-users = [ "@admin" "${user.accountName}" "root"];
      # auto-optimise-store = false;

      # trusted-substituters = [
      #   "https://cache.iog.io" # for haskell.nix
      # ];

      # trusted-public-keys = [
      #   "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      # ];
      cores    = 10;  # total number of logical cores: sysctl -n hw.ncpu
      max-jobs = 30;  # max 3 jobs per core


    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      # keep-outputs = false
      # keep-derivations = false
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
    # agenix.packages."${pkgs.system}".default
  ]; # ++ (import ./modules/packages.nix { inherit pkgs; });

  environment.etc."sudoers.d/10-nix-commands".text = with pkgs; ''
    ${user.accountName} ALL=(ALL:ALL) NOPASSWD: \
      /run/current-system/sw/bin/darwin-rebuild, \
      /run/current-system/sw/bin/nix-build, \
      /run/current-system/sw/bin/nix-channel, \
      /run/current-system/sw/bin/nix-collect-garbage, \
      ${pkgs.coreutils}/bin/env nix-env -p /nix/var/nix/profiles/system --set /nix/store/*, \
      ${pkgs.coreutils}/bin/env /nix/store/*/activate, \
      ${coreutils}/bin/cp ${_1password}/bin/op /usr/local/bin/op, \
      /etc/profiles/per-user/${user.accountName}/bin/openconnect, \
      /usr/bin/dscacheutil, \
      /usr/bin/killall, \
      /usr/bin/pkill, \
      /usr/bin/renice
  '';

  security = {
    # pam.enableSudoTouchIdAuth = true;

    # register additional (MITM) certificates
    pki.certificateFiles = [
#     "/etc/static/ssl/certs/nscacert.pem"
    ];
  };

  # used for backwards compatibility (check the change log first)
  system.stateVersion = 4;


  system.activationScripts.preUserActivation.text = with pkgs; ''
    # export PATH=${user.homeDirectory}/dotfiles/darwin/bin:$PATH

    launchctl setenv XDG_CACHE_HOME   ~/.xdg/cache
    launchctl setenv XDG_CONFIG_HOME  ~/.xdg/config
    launchctl setenv XDG_DATA_HOME    ~/.xdg/local/share
    launchctl setenv XDG_STATE_HOME   ~/.xdg/local/state
    # launchctl setenv GRADLE_USER_HOME ~/.xdg/local/share/gradle
    launchctl setenv DOCKER_CONFIG    ~/.xdg/config/docker
    # launchctl setenv KUBECONFIG       ~/.xdg/config/kube

    # 1Password integration requires the CLI binary at a specific location
    sudo ${coreutils}/bin/cp ${_1password}/bin/op /usr/local/bin/op

#     # set default handlers for Apple UTIs, URL schemes, file extensions, and MIME types
# #   duti $XDG_CONFIG_HOME/duti/   # must run *after* home-manager
#     duti ~/dev/dotfiles.nix/home/duti/
  '';

  # system.activationScripts.postUserActivation.text = ''
  #   # load Bunch automations – https://bunchapp.co/
  #   open 'x-bunch://setPref?configDir=~/.xdg/config/bunches'
  # '';

  environment.shells         = with pkgs; [ zsh nushell ];

  # recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  # zsh is the default shell on Mac and we want to make sure that we're
  # configuring the rc correctly with nix-darwin paths.
  programs.zsh.enable = true;
  # programs.zsh.shellInit = ''
  #   # Nix
  #   if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  #     . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  #   fi
  #   # End Nix
  #   '';

  # ;
  #
  # fonts.packages = with pkgs.unstable; [
  #   cascadia-code
  #   font-awesome
  #   monaspace
  #   ubuntu_font_family
  #   (nerdfonts.override { fonts = [ "Hasklig" "JetBrainsMono" ]; })
  # ];
}
