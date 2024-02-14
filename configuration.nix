# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # AMD GPU Drivers
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  # OpenCL/GL
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    # Blender Acceleration
    rocm-opencl-icd
    rocm-opencl-runtime
    # Enables amdvlk, which applications choose whether to use mesa or amdvlk
    amdvlk
    # Video Acceleration
    vaapiVdpau
    libvdpau-va-gl
  ];
  # Vulkan
  hardware.opengl.driSupport = true;

  # Kernel parameters
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  #boot.kernelParams = [  ];
  # Set Linux Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Automated Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  networking.hostName = "hal-9000"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryansamuels = {
    isNormalUser = true;
    description = "Ryan Samuels";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
      vesktop
      vscode
      stremio
      jellyfin-media-player
      prismlauncher
      r2modman
    ];
  };

  # Packages
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
  services.flatpak.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "ryansamuels";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Gnome Plugins
    gnomeExtensions.appindicator
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.vitals

    # Media
    vlc
    obs-studio
    audacity
    libsForQt5.kdenlive
    shotcut
    onlyoffice-bin
    firefox
    qbittorrent

    # Utilities
    gnome.gnome-software
    gnome3.gnome-tweaks
    git
    yt-dlp
    ffmpeg
    gamescope
    gamemode
    flatpak
    appimage-run
    man-pages
    man-pages-posix
    piper
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-color-emoji
    aegyptus
  ];

  # Auto Updates
  system.autoUpgrade = {
    enable = true;
    flags = [ "--update-input" "nixpkgs"  ];
    dates = "daily"; 
    flake = ".#hal-9000";
    persistent = true;
  };

  # Printers
  services.printing.drivers = [ pkgs.canon-cups-ufr2 ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
  };

  # List services that you want to enable:
  
  # Virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.vmware.host.enable = true;

  # Nix Configurations
  nix.optimise.automatic = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Services
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.ratbagd.enable = true;
  services.fwupd.enable = true;
  hardware.wooting.enable = true;

  # Documentation
  documentation.man.generateCaches = true;
  documentation.dev.enable = true;
  documentation.enable = true;

  # Enable a swap file
  swapDevices = [ {
    device = "/swapfile";
    size = 34*1024;
    randomEncryption.enable = true;
  } ];

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
  system.stateVersion = "23.05"; # Did you read the comment?
}