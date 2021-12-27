{ config, pkgs, lib, ... }: {
	home = {
		file = {
			bin = {
				source = ./bin;
				target = ".local/bin";
				recursive = true;
			};
		};
        packages = with pkgs; [
          solargraph
        ];
		sessionVariables = {
			EDITOR = "nvim";
			VISUAL = "nvim";
		};
	};

	xdg = {
		enable = true;
		userDirs.enable = true;
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

		dircolors = {
			enable = true;
			enableZshIntegration = true;

			extraConfig = (builtins.readFile ./dircolors);
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