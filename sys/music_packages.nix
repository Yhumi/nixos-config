{ config, pkgs, pkgs-nightly, nix-gaming, lib, ... }: 
{
  environment.systemPackages = with pkgs; [
    ardour
    darkice
    mixxx
    qpwgraph
    milkytracker    
  ];
}