{...}:

 {

    programs.wezterm = {
      enable = true;
      # package = inputs.wezterm.packages.${pkgs.system}.default; # using this requires a very long compilation from many libraries.
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };


}
