{ pkgs, inputs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.zellij;
  };

  xdg.configFile = {
    "zellij".source = ./config.kdl;
    # "zellij/layouts/riced.kdl".text = import ./layouts/riced.kdl.nix { inherit pkgs inputs; };
    # "zellij/layouts/riced.swap.kdl".source = ./layouts/riced.swap.kdl;
    # "zellij/themes".source = ./themes;
  };

  home.file."Library/Caches/org.Zellij-Contributors.Zellij/permissions.kdl".text = ''
    "${inputs.zjstatus}/bin/zjstatus.wasm" {
      RunCommands
      ReadApplicationState
      ChangeApplicationState
    }
  '';
}
