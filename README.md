# Nix-based macOS Setup

This repository contains the configuration files for a Nix-based macOS setup using Home Manager. It includes configurations for Zsh, Wezterm, tmux, and various CLI tools.

- Basic boilerplate for adding custom packages (under pkgs) and overlays (under overlay). Accessible on your system, home config, as well as nix build .#package-name.
- Boilerplate for custom NixOS (modules/nixos) and home-manager (modules/home-manager) modules
- NixOS and home-manager configurations from minimal, and they should also use your overlays and custom packages right out of the box.


## Install / Update home manager configuration

```bash
cd ~/nixconfig
make swtich
```

## Prerequisites

- macOS
- Basic knowledge of terminal usage

## Setup Instructions

1. Install Nix:
   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. Install Home Manager:
   ```bash
   nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   ```

3. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/nixconfig
   cd ~/nixconfig
   ```

4. Update the `home.nix` file:
   - Replace `YOUR_USERNAME` with your actual macOS username.
   - Adjust any other settings as needed.

5. Create necessary directories:
   ```bash
   mkdir -p ~/.config/home-manager/p10k-config
   ```

6. Copy configuration files:
   ```bash
   cp home.nix ~/.config/home-manager/
   cp p10k-config/p10k.zsh ~/.config/home-manager/p10k-config/
   ```

7. Install the Meslo Nerd Font:
   ```bash
   nix-env -iA nixpkgs.meslo-lgs-nf
   ```

8. Apply the configuration:
   ```bash
   home-manager switch
   ```

9. Restart your terminal or run:
   ```bash
   source ~/.zshrc
   ```

## Updating the Configuration

1. Make changes to the configuration files in your local `~/nixconfig` directory.

2. Copy the updated files to the Home Manager directory:
   ```bash
   cp home.nix ~/.config/home-manager/
   cp p10k-config/p10k.zsh ~/.config/home-manager/p10k-config/
   ```

3. Apply the changes:
   ```bash
   home-manager switch
   ```

4. Commit and push your changes to the Git repository:
   ```bash
   git add .
   git commit -m "Update configuration"
   git push
   ```

## Included Software and Configurations

- Zsh with Oh My Zsh
- Powerlevel10k theme
- Wezterm (terminal emulator)
- tmux
- Git
- eza (modern replacement for ls)
- zoxide (smart cd command)

## Customization

- To customize Powerlevel10k, edit the `p10k-config/p10k.zsh` file.
- To add or remove packages, edit the `home.packages` list in `home.nix`.
- To modify Zsh settings, update the `programs.zsh` section in `home.nix`.
- To change Wezterm configuration, modify the `programs.wezterm` section in `home.nix`.

## Troubleshooting

If you encounter any issues:
1. Ensure all prerequisites are installed correctly.
2. Check the Home Manager logs: `less ~/.local/state/home-manager/home-manager.log`
3. Try running `home-manager switch -v` for verbose output.

For more help, consult the [Home Manager manual](https://nix-community.github.io/home-manager/).


## References

- https://github.com/mitchellh/nixos-config
- https://github.com/Misterio77/nix-config
- https://github.com/hlissner/dotfiles
- https://github.com/dustinlyons/nixos-config
- https://github.com/librephoenix/nixos-config
- https://github.com/NixOS/templates
- https://github.com/jacobwgillespie/dotfiles
- https://github.com/breuerfelix/dotfiles

## Learning Nix/Nixos/Flakes

- https://nix.dev
- https://zero-to-nix.com
- https://nixos.wiki
- https://community.flake.parts/nixos-flake
- https://nixos.org/guides/nix-pills/
- https://nixos.org/manual/nixos/stable/
- https://nixos-and-flakes.thiscute.world/nixos-with-flakes/get-started-with-nixos
- Ultimate Nixos Guide: https://www.youtube.com/watch?v=a67Sv4Mbxmc
- https://edolstra.github.io/pubs/phd-thesis.pdf

## Devtools

- https://www.jetify.com/devbox/docs/
- https://flox.dev
- https://devenv.sh/
- https://www.nixhub.io/

## Deployment

- Nixops: https://github.com/nixops4/nixops4
- Deploy-rs: https://github.com/serokell/deploy-rs
- Cachix Deploy: https://docs.cachix.org/deploy/
- Nixos-infect: https://nixos.wiki/wiki/Install_NixOS_on_Hetzner_Cloud
- Nixos-anywhere

## TODO
- /etc/hosts
- sudoers NOPASSWD
- (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)


## Configure p10k

```bash
POWERLEVEL9K_CONFIG_FILE=/path/to/file p10k configure
```
