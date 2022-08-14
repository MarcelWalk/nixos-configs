{ config, pkgs, lib, options, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
    imports = [
        (import "${home-manager}/nixos")
    ];

    # ALLOW NON-FREE
    nixpkgs.config.allowUnfree = true;

    # BOOTLOADER
    boot = {
        loader = {
            grub = {
                enable = true;
                version = 2;
                efiSupport = true;
                efiInstallAsRemovable = true;
                efiSysMountPoint = "/boot/efi";
                device = "/dev/change_me";
            };
        };
    };

    # NETWORKING
    networking = {
        hostName = "walkm-nixos"; # Define your hostname.
        useDHCP = false; #DHCP here deprecated
        interfaces.enp3s0.useDHCP = true;
        # firewall.allowedTCPPorts = [ ... ];
        # firewall.allowedUDPPorts = [ ... ];
        firewall.enable = true;
    };

    # CONSOLE
    console = {
		font = "Lat2-Terminus16";
		keyMap = "en";
	};

    # LOCALIZATION
    time.timeZone = "Europe/Vienna";
    i18n.defaultLocale = "en_US.UTF-8";

    # PACKAGES
    environment.systemPackages = with pkgs; [
        neovim
        wget
        opera
        alacritty
        i3-gaps
        polybar
        dunst
        iwd
        feh
        maim
        xclip
        zsh
        nmap
        vscode
        htop
        neofetch
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
        displayManager.lightdm.greeters.mini = {
            enable = true;
            user = "walkm";
            extraConfig = ''
                [greeter]
                show-password-label = false
                [greeter-theme]
                background-image = "./wallpaper.jpg"
            '';
        };
        layout = "us";
        # ibinput.enable = true;
        videoDrivers = [ "nvidia" ];
        windowManager = {
            i3.package = pkgs.i3-gaps;
            i3.enable = true;
        };
    };

    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.opengl.enable = true;

    # SOUND
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # SERVICES
    services.openssh.enable = true;

    # USERS - DON'T FORGET TO SET PASSWD
    users.users.mwalk = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

    system = {
		autoUpgrade.enable = true;
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
		sudo.wheelNeedsPassword = true;
    };

    home-manager = {
		users.mwalk = (import ./home.nix);
		useUserPackages = true;
		useGlobalPkgs = true;
	};

    system.stateVersion = "21.11";
}