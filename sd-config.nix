# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-nightly, nix-gaming, jovian, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./sd-hardware-configuration.nix

      # Jovian Modules
      "${jovian}/modules"

      # Packages
      ./pkgs/basic_packages.nix
      ./pkgs/dev_packages.nix
      ./pkgs/aws.nix

      # Other
      ./sys/locale_gb.nix
      ./sys/network.nix
    ];

  # Define hostname for SteamDeck  
  networking.hostName = "steam";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;

    efi = {
      #efiSysMountPoint = "/boot/EFI";
      canTouchEfiVariables = true;
    };
  };

  # SteamDeck Hardware
  jovian.devices = {
    steamdeck = {
      enable = true;
    };
  };

  # Enable SteamBoot
  jovian.steam = {
    enable = true;
    autoStart = true;
    desktopSession = "plasma";
    user = "nicole";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    sddm = {
      #enable = true;
      wayland.enable = true;
    };
  };

  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nicole = {
    isNormalUser = true;
    description = "Nicole";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    pkgs-nightly.prismlauncher
  ];

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
