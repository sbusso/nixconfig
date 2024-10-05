{ config, user, pkgs, inputs, ... }:

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
    ./wezterm
    ./yazi
    (import ./zellij { inherit config user inputs pkgs; })
    ./zoxide
    ./zsh
  ];


}
