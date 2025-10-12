{ config, pkgs, pkgs-nightly, nix-gaming, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    #vim
    wget
    git
    neofetch

    direnv
    vscode-fhs
    via
    steam-run

    btop
    (symlinkJoin {
	    name = "kitty";
	    paths = [ pkgs.kitty ];
	    nativeBuildInputs = [ pkgs.makeWrapper ];
	    postBuild = ''
          wrapProgram $out/bin/kitty --set KITTY_CONFIG_DIRECTORY "${../ext/kitty}"
	    '';
    }) 
  ];

  programs.direnv.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.udev.packages = [ pkgs.via ];
  services.printing.enable = true;

  hardware.keyboard.qmk.enable = true;
}