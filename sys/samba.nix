{ config, ... }:
{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
	"server string" = "technophobia";
	"netbios name" = "technophobia";
	"security" = "user";
	"hosts allow" = "192.168.1.0/24 127.0.0.1 localhost ::1";
      };

      "private" = {
        "path" = "/mnt/nicole";
	"browseable" = "yes";
	"read only" = "no";
	"guest ok" = "no";
	"create mask" = "777";
	"directory mask" = "777";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
