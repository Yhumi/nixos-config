# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-nightly, copyparty, nix-minecraft, ... }:

{
  #nixpkgs.overlays = [ copyparty.overlays.default ];

  imports =
    [ # Include the results of the hardware scan.
      ./server-hardware.nix
      ./sys/samba.nix

      # MC Server
      #nix-minecraft.nixosModules.minecraft-servers
      ./sys/mc-server.nix

      ./sys/nginx.nix
      # bea's stupid gay website
      #./sys/bea-website.nix
    ];

  # Flake garbage
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  
  # Configure GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = false;
  boot.loader.grub.device = "/dev/sda";

  ## Networking
  networking.hostName = "technophobia"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  # MC Server Overlay
  # nixpkgs.overlays = [ nix-minecraft.overlay ];
  
  #services.minecraft-servers = {
  #  enable = true;
  #  eula = true;
  #  openFirewall = true;
  #  servers.vanilla = {
  #    enable = true;
  #    whitelist = {
  #      YhumiMiyei = "26d98353-0035-4273-9edd-50964d59a2b8";
  #      BobTheBob9 = "b0b64871-ada6-4c87-a272-0171b02f6551";
  #      Keris_XIV = "e15a2398-ded0-4f20-91ca-c35ba32f4907";
  #      Mythcall = "16ec217e-e08e-4f81-90be-6654d0b20573";
  #    };
  #    serverProperties = {
  #      server-port = 43565;
  #      difficulty = 2;
  #      gamemode = 0;
  #      max-players = 5;
  #      motd = "Miyei Minecraft Server";
  #      white-list = true;
  #      allow-cheats = false;
  #      enable-rcon = true;
  #      "rcon.password" = "Neru321!";
  #    };
  #    jvmOpts = "=Xms2048M -Xmx3072M";
  #    package = pkgs.vanillaServers.vanilla;
  #  };
  #};

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim
    neofetch
    wget

    git
    cifs-utils
  ];

  # Enable the OpenSSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "yes";
    };
  };

  # Copyparty
  # services.copyparty = {
  #   enable = true;
  
  #   user = "copyparty";
  #   group = "copyparty";

  #   settings = {
  #     i = "0.0.0.0";
  #     p = [ 3210 3211 ];
  #     no-reload = true;
  #     ignored-flag = false;
  #   };

  #  accounts = {
  #     yhumi.passwordFile = "";
  #     bea.passwordFile = "";
  #   };

  #   groups = {
  #     tch = [ "yhumi" "bea" ];
  #   };
   
  #   openFilesLimit = 8192;
  #};

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 80 5357 443 ]; # 445 139 ];
  networking.firewall.allowedUDPPorts = [ 3702 ]; # 137 138 ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

