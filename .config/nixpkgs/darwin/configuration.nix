{ config, pkgs, ... }:

{
	# Packages not implicitly installed below under `programs`
  environment.systemPackages =
		with pkgs; [
			bat
			delta
			fzf
			htop
			jack2
			julia-bin
			just
			neovim
			ninja
			ripgrep
			rustup
			tealdeer
			tmux
			vim

			fishPlugins.z
			fishPlugins.forgit
    ];

	# On first run, use:
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

	# manage Homebrew packages using Nix
	homebrew = {
		enable = true;

		brews = [
			"clang-format"
			"cmake"
			"ffmpeg"
			"dbus"
			"jack"
			"pkg-config"
			# "qmk"
		];

		casks = [
			"alacritty"
			"audacity"
			"blackhole-2ch"
			"discord"
			# "gcc-arm-embedded" # needed to build with QMK
			"gimp"
			"slack"
		];
	};

	programs = {
		# Create /etc/zshrc that loads the nix-darwin environment.
		zsh.enable = true; # DO NOT REMOVE

		# Install fish and load the nix-darwin environment into it.
		fish.enable = true;
	};

  # Auto-upgrade nix packages and run as a daemon
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

	# Allow using TouchID for sudo
	security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility. Before changing, run this and review:
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
