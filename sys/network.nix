{ pkgs, ... }:
{
    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon.
    #services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [  ];
    networking.firewall.allowedUDPPorts = [  ];
    # networking.firewall.allowedUDPPorts = [  ];
    # Or disable the firewall altogether.
    #networking.firewall.enable = false;

    systemd.services.wireproxy = {
        path = [ pkgs.wireproxy ];
        script = ''
            wireproxy -c /etc/wg.conf
        '';
        wantedBy = [ "multi-user.target" ];
    };
}
