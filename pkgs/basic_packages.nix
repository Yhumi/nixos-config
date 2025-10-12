{ config, pkgs, pkgs-nightly, nix-gaming, lib, ... }: 
{
  environment.systemPackages = with pkgs; [
    discord
    obs-studio
    youtube-music
    qbittorrent

    rar
    unrar    
  ];

  # Programs
  # Thanks for the firefox config Bea :3
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-devedition;
  programs.firefox.policies.CaptivePortal = false;
  programs.firefox.policies.DisableTelemetry = true;
  programs.firefox.policies.DisableFirefoxStudies = true;
  programs.firefox.policies.DisablePocket = true;
  programs.firefox.policies.DisableFirefoxAccounts = true;
  programs.firefox.policies.DisableAccounts = true;
  programs.firefox.policies.DisableFirefoxScreenshots = true;
  programs.firefox.policies.FirefoxHome = { Pocket = false; Snippets = false; TopSites = false; Highlights = false; };
  programs.firefox.policies.UserMessaging = { ExtensionRecommendations = false; SkipOnboarding = true; };
  programs.firefox.policies.EnableTrackingProtection = { Value = true; Locked = true; Cryptomining = true; Fingerprinting = true; };
  programs.firefox.policies.Extensions.Install = [
      "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      "https://addons.mozilla.org/firefox/downloads/latest/image-search-options/latest.xpi"
      "https://addons.mozilla.org/firefox/downloads/latest/translate-web-pages/latest.xpi"
      "https://addons.mozilla.org/firefox/downloads/latest/dashlane/latest.xpi"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}