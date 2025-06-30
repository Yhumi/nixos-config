{
  description = "hi i flaked a lil";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-nightly.url = "github:nixos/nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = inputs:
    let
      username = "nicole";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = inputs.nixpkgs.lib.nixosSystem
        {
          system = system;
          specialArgs = {
            pkgs-nightly = import inputs.nixpkgs-nightly { system = system; };
            nix-gaming = inputs.nix-gaming;
          };
          modules = [ ./configuration.nix ];
        };
      };
    };
}
