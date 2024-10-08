set fallback := true

_targets:
  @just --list --unsorted --list-heading $'Available targets:\n' --list-prefix "  "

# applies the latest nix-darwin configuration
@switch:
  darwin-rebuild switch --flake . --fallback --option eval-cache false

# removes derivations from older nix-darwin generations
@gc:
  sudo nix-collect-garbage --delete-old

# updates the top-level flake lock file
@update:
  nix flake update --commit-lock-file --commit-lockfile-summary "update Nix flake inputs"

# lists fingerprints of all SSH keys the 1Password SSH agent can access
@ssh-keys:
  SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ssh-add -l

# fixes line separators from CRLF to LF for all Obsidian community plugins and themes
@fix-line-separators:
  fd '.+' .obsidian/{plugins,themes} --exec dos2unix {} \;
