{ config, pkgs, ... }:

let
  home = "/Users/${config.system.primaryUser}";
in
{
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;

        # show desktop when cursor is moved to the bottom left corner of the screen
        wvous-bl-corner = 4;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv"; # prefer list view
        ShowPathbar = true;
        QuitMenuItem = true;
      };

      screencapture.disable-shadow = true;

      WindowManager.EnableStandardClickToShowDesktop = false;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    primaryUser = "gsk";
  };

  # Packages not implicitly installed below under `programs`
  environment.systemPackages =
    with pkgs; [
      alacritty
      alacritty.terminfo
      audacity
      bat
      cargo-sweep
      (callPackage ./darktable.nix { })
      delta
      ffmpeg
      fzf
      htop
      # julia-bin
      just
      lua-language-server
      neovim
      ninja
      ripgrep
      rustup
      tealdeer
      tmux

      fishPlugins.z
      fishPlugins.forgit
    ];

  # On first run, use:
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "${home}/.config/nixpkgs/darwin/configuration.nix";

  # manage Homebrew packages using Nix
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "dbus"
      "jack"
      "pkg-config"
      # "qmk"
    ];

    casks = [
      "blackhole-2ch"
      "discord"
      # "gcc-arm-embedded" # needed to build with QMK
      "gimp"
      "keymapp"
      "pd"
      "processing"
      "slack"
    ];
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true; # DO NOT REMOVE

    # Install fish and load the nix-darwin environment into it.
    fish.enable = true;

    # use direnv to dynamically load dev shells.
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # macOS zsh reads the terminfo search path only at startup. Set it for GUI apps so that shells
  # started by terminal emulators find Nix terminfo entries (e.g. alacritty).
  launchd.user.envVariables.TERMINFO_DIRS = [
    "/run/current-system/sw/share/terminfo"
    "/usr/share/terminfo"
  ];

  # Clean up Rust target directories weekly
  launchd.user.agents.cleanup-rust-target-dirs = {
    script = ''
      echo "cleanup-rust-target-dirs started $(date)"
      for target in "$HOME"/dev/*/target; do
        project=$(dirname "$target")
        [ -f "$project/Cargo.toml" ] || continue
        if pgrep -qx rust-analyzer; then
          echo "rust-analyzer is running, skip deleting its target dir in project $project"
        else
          rm -rf "$target/rust-analyzer"
        fi
        cargo sweep --time 14 "$project"
      done
    '';
    path = [ pkgs.coreutils pkgs.rustup pkgs.cargo-sweep ];
    serviceConfig = {
      StartCalendarInterval = [ { Weekday = 0; Hour = 23; Minute = 0; } ];
      StandardOutPath = "${home}/Library/Logs/cleanup-rust-target-dirs.log";
      StandardErrorPath = "${home}/Library/Logs/cleanup-rust-target-dirs.log";
      ProcessType = "Background";
    };
  };

  # Auto-upgrade nix packages
  nix.package = pkgs.nix;

  # Allow using TouchID for sudo
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  # Used for backwards compatibility. Before changing, run this and review:
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
