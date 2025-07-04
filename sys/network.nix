{
    # Enable networking
    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon.
    #services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [  ];
    # networking.firewall.allowedUDPPorts = [  ];
    # Or disable the firewall altogether.
    #networking.firewall.enable = false;
}
