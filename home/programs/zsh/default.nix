{ config, pkgs, user, ... }:

{
  # home.packages = with pkgs; [
  #   antibody
  #   powerline-go
  #   vivid
  # ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    package = pkgs.zsh;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./.;
        file = "p10k.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
    initExtra = ''
      # Powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Better history completion
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Zoxide
      eval "$(zoxide init zsh)"

      # fzf
      if [ -n "''${commands[fzf-share]}" ]; then
          source "$(fzf-share)/key-bindings.zsh"
          source "$(fzf-share)/completion.zsh"
      fi

      # eval "$(direnv hook zsh)" # set by direnv package


    '';
    shellAliases = {
      # eza (ls replacement) aliases
      ls = "eza --icons=always";
      ll = "eza -l --icons=always";
      la = "eza -la --icons=always";
      lt = "eza -T --icons=always";

      # General aliases
      cd = "z";
      cat = "bat";
      find = "fd";
      grep = "rg";
      top = "htop";

      # Git aliases
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gst = "git status";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
      lg = "lazygit";

      n = "nix develop -c $SHELL";

      # Misc aliases
      reload = "source ~/.zshrc";
      tree = "eza --tree";
      # Add nano alias for micro
      nano = "micro";

      # You might want to keep an alias to the real nano just in case
      realnano = "/usr/bin/nano";
    };

  };

  programs.command-not-found.enable = true;

#  xdg.configFile."zsh".source = ./.;
  # xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh";

#  home.file.".zshenv".source = ./zsh/zshenv;
  # home.file.".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/zsh/zshenv";
}
