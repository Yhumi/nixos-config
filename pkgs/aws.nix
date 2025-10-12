{ config, pkgs, pkgs-nightly, nix-gaming, lib, ... }: 
{
  environment.systemPackages = with pkgs; [
    mountpoint-s3
    awscli2  
  ];
}