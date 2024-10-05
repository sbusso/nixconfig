{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Stephane Busso";
    userEmail = "stephane.busso@gmail.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      core = {
        editor = "micro";
      };
      color = {
        ui = true;
      };
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "sbusso";
      push.default = "tracking";
      init.defaultBranch = "main";
      # gpg = {
      #     format = "ssh";
      # };
      # "gpg \"ssh\"" = {
      #     program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      # };
      # commit = {
      #     gpgsign = true;
      # };

      # user = {
      #     signingKey = "...";
      # };
    };
  };
}
