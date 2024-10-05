alias nix:daemons="sudo pkill -9 nix-daemon"
alias nix:gc="sudo nix-collect-garbage --delete-old"
alias nix:tree="nix-store -q --tree"
alias nix:upgrade="sudo -i sh -c 'nix-channel --update && nix-env --install --attr nixpkgs.nix --fallback && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'"
alias nix-cli:upgrade="nix upgrade-nix"
