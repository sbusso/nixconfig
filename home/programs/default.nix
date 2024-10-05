{ config, user, pkgs, inputs, unstable, ... }:

{
  imports = [
    (import ./aerospace { inherit config user pkgs; })
    ./bat
    ./direnv
    ./fzf
    ./git
    ./lazygit
    ./micro
    # ./nvim
    # ./presenterm
    ./ripgrep
    ./silicon
    ./tmux
    (import ./wezterm { inherit unstable; })
    ./yazi
    (import ./zellij { inherit config user inputs pkgs; })
    ./zoxide
    ./zsh
  ];


}
