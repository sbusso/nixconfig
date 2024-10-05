{unstable, ...}:

 {

    xdg.configFile = {
      "wezterm/wezterm.lua".source = ./wezterm.lua;
    };
    programs.wezterm = {
      enable = true;
      # package = unstable.wezterm;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };



    # WEZTERM_CONFIG_DIR=/Users/sbusso/.config/wezterm
    # WEZTERM_CONFIG_FILE=/Users/sbusso/.config/wezterm/wezterm.lua


}
