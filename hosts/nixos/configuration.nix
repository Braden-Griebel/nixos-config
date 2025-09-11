# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  system,
  ...
}: let
  desktopSettings = config.desktopSettings;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Home manager module
    inputs.home-manager.nixosModules.default
    # Settings for which desktop environments to setup
    ../../desktopSettings.nix
    # Steam module
    ../../modules/nixos/steam.nix
  ];

  # Lix setup
  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (final.lixPackageSets.stable)
        nixpkgs-review
        nix-direnv
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Steam
  steam.enable = true;

  # Desktop settings
  desktopSettings.niri.enable = true;
  desktopSettings.hyprland.enable = true;
  desktopSettings.kde.enable = true;
  desktopSettings.gnome.enable = false;

  # Enable Flakes and nix commands
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Fix for virtualbox
  boot.kernelParams = ["kvm.enable_virt_at_load=0"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Setup Podman
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable VirtualBox
  virtualisation.virtualbox = {
    host.enable = true;
    # host.enableKvm = true;
    # host.enableExtensionPack = true;
    # host.addNetworkInterface = false;
  };
  users.extraGroups.vboxusers.members = ["bgriebel"];

  # # Enable Virt-manager
  # programs.virt-manager.enable = true;
  # users.groups.libvirtd.members = ["bgriebel"];
  # virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm = {
  #   enable = false;
  #   theme = "catppuccin-sddm-corners";
  # };
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = "en";
    };
  };

  # Enable/disable kde and gnome desktops
  services.desktopManager.plasma6.enable = desktopSettings.kde.enable;
  services.desktopManager.gnome.enable = desktopSettings.gnome.enable;

  # Enable/disable the hyprland package
  programs.hyprland = {
    enable = desktopSettings.hyprland.enable;
    xwayland.enable = true;
  };
  # Enable hyprlock under pam
  security.pam.services.hyprlock = {};

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bgriebel = {
    isNormalUser = true;
    description = "Braden Griebel";
    extraGroups = ["networkmanager" "wheel" "seat" "input"];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Setup home manager
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      system = system;
      desktopSettings = desktopSettings;
    };
    users = {
      "bgriebel" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install niri if desired
  programs.niri.enable = desktopSettings.niri.enable;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
    ]
    ++ lib.optionals
    (desktopSettings.niri.enable || desktopSettings.hyprland.enable)
    [
      networkmanagerapplet
      blueman
      brightnessctl
    ]
    ++ lib.optionals desktopSettings.niri.enable [pkgs.xwayland-satellite];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
