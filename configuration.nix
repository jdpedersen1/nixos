# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Use the systemd-boot EFI boot loader.
#boot.loader.systemd-boot.enable = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "Nix"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
        networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
        time.timeZone = "America/Chicago";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkbOptions in tty.
# };

# Enable the X11 windowing system.
    services.xserver = {
        layout = "us";
        xkbVariant = "";
        enable = true;
        displayManager.sddm = {
            enable = true;
            theme = "maya";
            autoNumlock = true;
        };
    };

# Allow Unfree packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowInsecure = true;
    nixpkgs.config.PermittedInsecurePackages = [
	  "python-2.7.18.6"
    ];

    programs.hyprland = {
        enable = true;
    };

    programs.hyprland.xwayland = {
        hidpi = true;
        enable = true;
    };


# Configure keymap in X11

# services.xserver.layout = "us";
# services.xserver.xkbOptions = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
    services.printing = {
        enable = true;
        drivers = [ pkgs.epson-escpr ];
        browsing = true;
        defaultShared = true;
    };

    services.blueman.enable = true;
    services.gnome3.gnome-keyring.enable = true;
# Enable sound.
    sound.enable = true;
# hardware.pulseaudio.enable = true;
# hardware.bluetooth.enable = true;
    hardware = {
    #    pulseaudio.enable = true;
        bluetooth.enable = true;
    };
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jake = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "kvm" ]; # Enable ‘sudo’ for the user.
            packages = with pkgs; [
      cinnamon.nemo-with-extensions
#     firefox-wayland
#     vim
#     neofetch
#     alacritty
#     kitty
#     hyprland
#     tree
            ];
    };

    services.locate = {
        enable = true;
        locate = pkgs.mlocate;
    };

# environment etc
    environment.etc = {
	"xdg/gtk-3.0" .source = ./gtk-3.0;
    };

# Environment variables
    environment = {
        variables = {
        QT_QPA_PLATFORMTHEME = "qt5ct";
        QT_QPA_PLATFORM = "xcb obs";
        };
    };


# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#rustup
            alacritty
            audacity
            brave
            blueman
            brightnessctl
            brillo
            cargo
            cinnamon.nemo-with-extensions
            cmake
            dracula-theme
            emacs
            eww-wayland
            firefox-wayland
            flameshot
            fontpreview
            fzf
            gcc
            gcolor2
            gimp
            git
            glibc
            gnome.gnome-keyring
            gnumake
            go
            gparted
            gtk3
            hplip
            hugo
            hyprland
            hyprpaper
            hyprpicker
            jp2a
            kdenlive
            kitty
            libreoffice
            libsecret
            libvirt
            lsd
            lxappearance
            mailspring
            meson
            mpv
            neofetch
            ninja
            networkmanagerapplet
            obs-studio
             (pkgs.wrapOBS {
                plugins = with pkgs.obs-studio-plugins; [
                    wlrobs
                ];
            })
            pavucontrol
            pipewire
            pkg-config
            polkit_gnome
            qemu_kvm
            qt5.qtwayland
            qt6.qmake
            qt6.qtwayland
            ranger
            ripgrep
            rofi-wayland
            rustup
            scrot
            sddm
            shellcheck
            silver-searcher
            simplescreenrecorder
            tldr
            trash-cli
            unzip
            virt-viewer
            waybar
            wget
            wireplumber
            wl-color-picker
            wofi
            wlroots
            xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
            xdg-utils
            xwayland
            ydotool
            zoxide
            ];

    fonts.fontDir.enable = true;
    fonts.fonts = with pkgs; [  
        nerdfonts
        font-awesome
        google-fonts
    ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
 programs.gnupg.agent = {
   enable = true;
   enableSSHSupport = true;
 };

# List services that you want to enable:
    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    services.dbus.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk
        ];
    }; 
# Enable the OpenSSH daemon.
 services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

        nixpkgs.overlays = [
        (self: super: {
         waybar = super.waybar.overrideAttrs (oldAttrs: {
                 mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                 });
         })
        ];}

