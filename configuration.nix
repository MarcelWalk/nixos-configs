{ config, pkgs, lib, options, ... }:

{

    # IMPORTS
    imports =
    [
        ./hardware-configuration.nix
        <home-manager/nixos>
    ];

    # ALLOW NON-FREE
    nixpkgs.config.allowUnfree = true;

    # BOOTLOADER
    boot = {
        loader = {
            grub = {
                enable = true;
                version = 2;
                # efiSupport = true;
                # efiInstallAsRemovable = true;
                # efiSysMountPoint = "/boot/efi";
                device = "/dev/vda";
            };
        };
    };

    # NETWORKING
    networking = {
        hostName = "nixos"; # Define your hostname.
        useDHCP = false; #DHCP here deprecated
        interfaces.enp3s0.useDHCP = true;
        # firewall.allowedTCPPorts = [ ... ];
        # firewall.allowedUDPPorts = [ ... ];
        # firewall.enable = false;
    };

    # CONSOLE
    console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

    # LOCALIZATION
    time.timeZone = "Europe/Vienna";
    i18n.defaultLocale = "en_US.UTF-8";

    # PACKAGES
    environment.systemPackages = with pkgs; [
        neovim
        wget
        chromium
        alacritty
        i3-gaps
        feh
        zsh
    ];
    environment.pathsToLink = [ "/share/zsh" ];

    fonts = {
		enableDefaultFonts = true;

		fonts = with pkgs; [
			source-code-pro source-sans-pro source-serif-pro
			noto-fonts noto-fonts-cjk noto-fonts-emoji
			liberation_ttf opensans-ttf corefonts nerdfonts 
		];
	};

    # X11
    services.xserver = {
        enable = true;
        layout = "us";
        # ibinput.enable = true;
        windowManager = {
            i3.enable = true;
        };
    };

    # SOUND
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # SERVICES
    services.openssh.enable = true;

    # USERS - DON'T FORGET TO SET PASSWD
    users.users.mwalk = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
				pavucontrol flameshot
				discord element-desktop
				git 
				python3 direnv lutris
				steam 
		];
    };

    environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

    system = {
		autoUpgrade.enable = false;
	};

    virtualisation = {
		libvirtd = {
			enable = true;
			qemuOvmf = true;
			qemuRunAsRoot = false;
			onShutdown = "shutdown";
		};
		docker.enable = true;
	};

    security = {
		sudo.wheelNeedsPassword = false;
    };

    home-manager = {
		users.mwalk = (import ./home.nix);
		useUserPackages = true;
		useGlobalPkgs = true;
	};

    system.stateVersion = "21.11";
    
}