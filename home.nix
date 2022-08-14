{ config, pkgs, lib, ... }: {
	home = {
        packages = with pkgs; [
				pavucontrol
				discord 
				element-desktop
				git 
				python3 
				direnv 
				anydesk
				easyeffects
		];
		sessionVariables = {
			EDITOR = "nvim";
			VISUAL = "nvim";
		};
	};

	xdg = {
		enable = true;
		userDirs.enable = true;

		configFile."alacritty/config.yml".source = ./dots/alacritty/alacritty.yml;
		configFile."dunst/dunstrc".source = ./dots/dunst/dunstrc;
		configFile."i3/config".source = ./dots/i3/config;
		configFile."neofetch/config.conf".source = ./dots/neofetch/config.conf;
		configFile."polybar/config.ini".source = ./dots/polybar/config.ini;
		configFile."rofi/config.rasi".source = ./dots/rofi/config.rasi;
		configFile."rofi/slate.rasi".source = ./dots/rofi/slate.rasi;
	};

	fonts.fontconfig.enable = true;

	gtk = {
		font = {
			package = pkgs.source-sans-pro;
			name = "Source Sans Pro 11";
		};
		theme.name = "Adwaita-dark";
	};

	qt = {
		enable = true;
		platformTheme = "gnome";
		style = {
			package = pkgs.adwaita-qt;
			name = "adwaita-dark";
		};
	};

	programs = {
		obs-studio = {
			enable = true;
		};

		git = {
			enable = true;
			userName  = "MarcelWalk";
			userEmail = "walk.marcel.97[at]googlemail.com";
  	};

		steam = {
			enable = true;
			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  	};

		zsh = {
			enable = true;
			enableAutosuggestions = true;
			enableCompletion = true;
			# enableVteIntegration = true;
			autocd = true;
			dotDir = ".config/zsh";

			sessionVariables = {
				EDITOR = "nvim";
				VISUAL = "nvim";
				NIX_AUTO_RUN = 1;
				MOZ_USE_XINPUT2 = 1;
			};
		};

		direnv = {
			enable = true;
            nix-direnv = {
              enable = true;
              enableFlakes = true;
            };
			enableZshIntegration = true;
		};

		ssh = {
			enable = true;
			compression = true;
			controlMaster = "auto";
			controlPersist = "30m";
			forwardAgent = true;
		};
	};
}