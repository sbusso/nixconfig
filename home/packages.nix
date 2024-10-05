{ pkgs, inputs, ... }:

with pkgs;
let
  securityTools = [
    _1password
    age
    gnupg
    openssl
    sops
    teller
  ];

  coreTools = [
    cachix
    coreutils-prefixed
    devenv
    moreutils

    # delta
    # dos2unix
    # dua
    # dyff
    eza # Better ls
    zoxide # Better cd
    # tmux
    bash # Newer version of bash
    wezterm
    ripgrep # Better grep
    fd # Better find
    bat # Better cat
    fzf # Fuzzy finder
    jq # JSON processor
    yq # YAML processor
    inputs.nixvim.packages.${pkgs.system}.default

    gh # GitHub CLI
    gh-dash # GitHub dashboard
    neofetch # System info
    tree # Directory listings
    # micro # Terminal text editor
    go-task
    # direnv
    glow
#   gnused
    gzip
    hyperfine
    just
    lsd
    sd
    # skim
    # slides
    stderred # legacyPackages.x86_64-darwin.stderred
    unrar
    unzip
    viu
    watch
    watchexec
    xz
    zip
  ];

  systemTools = [
    bottom # Interactive process viewer
    gdu
    htop # Interactive process viewer
    btop # Interactive process viewer
    fastfetch
    nushell
    pueue

    socat
    termshark
    watchman
  ];

  gitTools = [
    git
    git-crypt
    diff-so-fancy
    lazygit
  ];

  goTools = [
    go
    gopls
  ];

  httpTools = [
    # aria2
    # xh
  ];

  languageTools = [
    gettext
    grex
    rlwrap

    # kotlin
    # lua54Packages.lua
    # lua54Packages.luarocks

    helix
    tree-sitter
  ];


  pythonTools = [
    # basedpyright
    black
    pdm
    pur
    ruff

    python312
#    (python312.withPackages (pkgs: with pkgs; [ pip pynvim ]))
  ];

  dataTools = [
    fq
    fx
    ijq
    jnv
    jq
    # yq-go
    # tabiew
  ];

  otherTools = [
    jetbrains-mono
    keka
    tailscale
  ];

in
{
  home.packages = []
    ++ securityTools
    ++ coreTools
    ++ systemTools
    ++ gitTools
    ++ httpTools
    ++ languageTools
    ++ goTools
    ++ pythonTools
    ++ dataTools
    ++ otherTools
    ;
}
