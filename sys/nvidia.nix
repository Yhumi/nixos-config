{ config, ... }:
{
    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    # Nvidia hardware
    hardware.nvidia = {

        # Modesetting is required.
        package = config.boot.kernelPackages.nvidiaPackages.production;

        modesetting.enable = true;

        powerManagement.enable = true;
        powerManagement.finegrained = false;

        open = false;
        nvidiaSettings = true;

    };

    # Enable OpenGL
    hardware.graphics = {
        enable = true;
    };
}
