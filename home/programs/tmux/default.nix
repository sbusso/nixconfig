{pkgs, ...}: let
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

programs.tmux = {
  enable = true;
  terminal = "xterm-256color";
  shortcut = "s";
  secureSocket = false;
  # shell = "${pkgs.zsh}/bin/zsh";
  baseIndex = 1;
  clock24 = true;
  historyLimit = 3000;
  mouse = true;

  plugins = with pkgs;
        [
          # {
          #   plugin = tmux-super-fingers;
          #   extraConfig = "set -g @super-fingers-key f";
          # }
          # tmuxPlugins.tpm
          tmuxPlugins.sensible
          tmuxPlugins.cpu
          # tmuxPlugins.sessionx
          tmuxPlugins.better-mouse-mode
          {
              plugin = catppuccin;
              extraConfig = ''

              set -g @catppuccin_flavour 'mocha'

              set -g @@catppuccin_window_status_style "slanted"
              set -g @catppuccin_window_number_position "right"

              set -g @catppuccin_window_default_fill "number"

              set -g @catppuccin_window_current_fill "number"
              set -g @catppuccin_window_current_text "#{pane_current_path}"

              # set -g window-status-format " #T | #I "
              # set -g window-status-current-format " #T | #I "

              set -g @catppuccin_status_left_separator  ""
              set -g @catppuccin_status_right_separator " "
              set -g @catppuccin_status_fill "all"
              set -g @catppuccin_status_connect_separator "yes"
              set -g @catppuccin_status_background "none"
              '';
          }
          {
              plugin = tmuxPlugins.resurrect;
              extraConfig = ''
              set -g @resurrect-strategy-vim 'session'
              set -g @resurrect-strategy-nvim 'session'
              set -g @resurrect-capture-pane-contents 'on'
              '';
          }
          {
              plugin = tmuxPlugins.continuum;
              extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-boot 'on'
              set -g @continuum-save-interval '10'
              '';
          }
        ];


        extraConfig = ''
          set -g status-left ""
          set -g  status-right "#{E:@catppuccin_status_directory}"
          set -ag status-right "#{E:@catppuccin_status_user}"
          set -ag status-right "#{E:@catppuccin_status_host}"
          set -ag status-right "#{E:@catppuccin_status_session}"

          set-option -sa terminal-overrides ",xterm*:Tc"

          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          bind -n M-H previous-window
          bind -n M-L next-window



          # status bar at the top
          set -g status-position top

          set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
          set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
          bind '\' set status
          # if-shell "[[ $(tmux lsw | wc -l) -le 1 ]]" 'set -g status'
          # set -g status on


        '';

};
}
