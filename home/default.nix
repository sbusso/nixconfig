{
  config,
  lib,
  pkgs,
  unstable,
  user,
  isWSL,
  inputs,
  isDarwin,
  ...
}: let
  # sharedPackages = import ./packages.nix {inherit pkgs;};
  username = user.accountName;
  homeDirectory = user.homeDirectory;

  # tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin
  #     {
  #       pluginName = "tmux-super-fingers";
  #       version = "unstable-2023-01-06";
  #       src = pkgs.fetchFromGitHub {
  #         owner = "artemave";
  #         repo = "tmux_super_fingers";
  #         rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
  #         sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
  #       };
  #     };



  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin
      {
        pluginName = "catppuccin";
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "tmux";
          rev = "b954fd2080182250104daea2a628cb15daecf5ce";
          sha256 = "sha256-XQO7k5XFoAk9AeKCh229s1gJzKbyvzloRvmQfYmVo1w=";
        };
        postInstall = ''
              sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
            '';
      };

in {

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  home = {
    enableNixpkgsReleaseCheck = false;
    # extraOutputsToInstall = [ "man" ];
    stateVersion = "24.05";
    username = username;
    homeDirectory = homeDirectory;
  };

  imports = [
    (import ./packages.nix { inherit pkgs inputs; })
    (import ./programs { inherit config lib pkgs user inputs unstable; })
  ];




  xdg = {
    enable = true;

    # cacheHome  = "${user.homeDirectory}/.xdg/cache";
    # configHome = "${user.homeDirectory}/.xdg/config";
    # dataHome   = "${user.homeDirectory}/.xdg/local/share";
    cacheHome  = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome   = "${config.home.homeDirectory}/.local/share";

    # TODO: Check if we can use this pattern and offer a way to override it
    # configFile = with config.lib.file; {
    #   "1Password".source   = ./1Password;
    #   "duti".source        = ./duti;
    #   "fastfetch".source   = ./fastfetch;
    #   "git".source         = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/git";
    #   "luarocks".source    = ./luarocks;
    #   "wezterm".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/wezterm";
    #   "zathura".source     = mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zathura";
    # };
  };



  # manual.manpages.enable = true;
  # programs.man.enable = false; # needed so that host OS man pages remain accessible


  programs.ssh = {
    enable = true;
    forwardAgent = true;
    compression = true;
    extraConfig = ''
        Host *
              # IdentityAgent ~/.1password/agent.sock
              # UseKeychain yes
              IdentityFile ~/.ssh/id_rsa_sr

        Host pf
            HostName 144.76.113.170
            TCPKeepAlive yes
            User deployer
            PubkeyAcceptedKeyTypes +ssh-rsa
            HostKeyAlgorithms +ssh-rsa
        '';
    # agents = {
    #   ssh = {
    #     enable = true;
    #     start = true;
    #     identities = [
    #       {
    #         path = "${homeDirectory}/.ssh/id_rsa";
    #         comment = username;
    #       }
    #     ];
    #   };
    # };
  };



  programs.go = {
    enable = true;
    goPath = "code/go";
    goPrivate = ["github.com/sbusso"];
  };


  programs.direnv = {
    enable = true;


    enableZshIntegration = true;
  };

  # programs.starship = {
  #     enable = true;
  #     settings = pkgs.lib.importTOML ./dotfiles/starship/starship.toml;
  #   };


  # programs.kitty = {
  #   enable = true;
  # };

  # Tmux configuration


  programs.awscli = {
    enable = true;
    # settings = {
    #   region = "eu-west-3";
    #   output = "json";
    # };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_latte"; # empty settings required to enable config.
    };
    extraConfig = builtins.readFile ./dotfiles/btop/btop.conf;
  };

  # Fonts
  fonts.fontconfig.enable = true;

  # Allow unfree packages (if needed)
  nixpkgs.config.allowUnfree = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # "./.config/sketchybar/" = {
    #   source = ./dotfiles/sketchybar;
    #   recursive = true;
    # };

    "./.config/btop/themes/" = {
      source = ./dotfiles/btop/themes;
      recursive = true;
    };


    # ".aerospace.toml".source = ./dotfiles/aerospace.toml;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/zed/settings.json".source = ./dotfiles/zed/settings.json;

  };

  # xdg.configFile."aerospace/config" = lib.mkIf pkgs.stdenv.isDarwin {
  #     source = ./aerospace.toml;
  #   };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sbusso/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
    path = pkgs.home-manager;
  };
}
