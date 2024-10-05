{
  homebrew = {
    enable     = true;

    global = {
      autoUpdate = true;
      brewfile   = true;
    };

    onActivation = {
      autoUpdate = true;
      upgrade    = true;
      cleanup    = "zap"; # "uninstall";
    };

    taps = [
      # "homebrew/bundle"
      # "martido/homebrew-graph"
      # "FelixKratz/formulae"
      "localsend/localsend"
      "nikitabobko/tap"
    ];

    brews = [
    "bmon"
    # "sketchybar"
    "borders"
    # "helix"


    # sketchybar helpers
    # "switchaudio-osx"
    # "nowplaying-cli"
    ];

    casks = [
      {
        # 1Password warns that it will neither fill nor save logins
        # in browsers when it isn't installed under /Applications
        name = "1password";
        args = { appdir = "/Applications"; };
      }
      "aerospace"
      "cleanshot"
      # "alfred"
      # {
      #   name = "amadeus-pro";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # "arc"
      # {
      #   name = "audio-hijack";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # {
      #   name = "beeper";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # # "bunch"
      # {
      #   name = "cloudflare-warp";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # {
      #   name = "daisydisk";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      "discord"

      "imageoptim"
      {
        name = "docker";
        args = { appdir = "/Applications"; };
      }
      # "dropbox"
      # {
      #   name = "duckduckgo";
      #   args = { appdir = "/Applications"; };
      # }
      "firefox"
      # "opera"
      # "zen-browser"
      # "expressvpn"
      "istat-menus"
      # "monodraw"
      "raycast"
      # "rectangle"
      # "screenflow"
      "meetingbar" # shows upcoming meetings
      "slack"
      "visual-studio-code"
      "zed"
      {
        name = "hammerspoon";
        args = { appdir = "/Applications"; };
      }
      # "jetbrains-toolbox"
      "keycastr"
      # "kitty"
      "localsend"
      # {
      #   name = "logitech-options";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # {
      #   name = "logi-options+";
      #   args = { require_sha = false; }; # missing sha256 checksum
      # }
      # {
      #   name = "megasync";
      #   args = {
      #     appdir = "/Applications";
      #     require_sha = false; # missing sha256 checksum
      #   };
      # }
      "obsidian"
      "utm"
      "postman"
      {
        name = "orbstack";
        args = { appdir = "/Applications"; };
      }
      "pop"
      "raindropio"
      {
        name = "secretive";
        args = { appdir = "/Applications"; };
      }
      # "sonos-s1-controller"

      # "teamviewer"
      "tuple"
      "vlc"
      # "wezterm"
      {
        # Zoom must also be installed under /Applications
        name = "zoom";
        args = { appdir = "/Applications"; };
      }
      "shottr"
      "balenaetcher"
      "appcleaner"
      "fantastical"
      "superproductivity"
      "transmission"
      "wireshark"
      "yaak"
      "font-jetbrains-mono"
      "font-hack-nerd-font"
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
    ];

    caskArgs = {
      # appdir = "~/Applications/Homebrew Apps";
      no_quarantine = true;
      require_sha = true;
    };
  };
}
