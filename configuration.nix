# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-nightly, nix-gaming, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Packages
      ./pkgs/basic_packages.nix
      ./pkgs/dev_packages.nix
      ./pkgs/music_packages.nix
      ./pkgs/aws.nix

      #Other
      ./sys/locale_gb.nix
      ./sys/nvidia.nix
      ./sys/pipewire.nix
      ./sys/network.nix
    ];

  # Define hostname for PC config
  networking.hostName = "nixos";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;

    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = false;

    efi = {
      # efiSysMountPoint = "/boot/EFI";
      canTouchEfiVariables = true;
    };

    grub = {
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable windowing system.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nicole = {
    isNormalUser = true;
    description = "Nicole";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    pkgs-nightly.prismlauncher
    
    sbctl
    wireproxy
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;    
  };

  # Misc
  environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
