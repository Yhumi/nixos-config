{ pkgs, config, ... }: 
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    openFirewall = true;
    whitelist = {
      YhumiMiyei = "26d98353-0035-4273-9edd-50964d59a2b8";
      BobTheBob9 = "b0b64871-ada6-4c87-a272-0171b02f6551";
      keris_xiv = "e15a2398-ded0-4f20-91ca-c35ba32f4907";
      Mythcall = "16ec217e-e08e-4f81-90be-6654d0b20573";
    };
    serverProperties = {
      server-port = 43565; # Default Port
      difficulty = 2; # 2 = Normal
      gamemode = 0;
      max-players = 4;
      motd = "Miyei Minecraft Server";
      white-list = true;
      allow-cheats = false;
      enable-rcon = true;
      "rcon.password" = "Neru321!";
    };
    jvmOpts = "-Xms2048M -Xmx3072M";

    package = pkgs.callPackage ( pkgs.fetchurl { 
    	url = "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/nixos-25.11/pkgs/games/minecraft-servers/derivation.nix"; 
	sha256 = "sha256-4tQ2CcK0CShXf3owOMhbNCIquAb4W+kLbmgDZg2qs5o="; 
    }) {
	version = "26.1";
     	url = "https://piston-data.mojang.com/v1/objects/3872a7f07a1a595e651aef8b058dfc2bb3772f46/server.jar";
	sha1 = "OHKn8HoaWV5lGu+LBY38K7N3L0Y=";
	jre_headless = pkgs.javaPackages.compiler.openjdk25;
    };
  };
}
