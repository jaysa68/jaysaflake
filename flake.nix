{
  description = "jaysa nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      nixvim,
      claude-code,
      ...
    }:
    let
      system = "x86_64-linux";

      mkHost =
        host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${host}
            { nixpkgs.overlays = [ nur.overlays.default claude-code.overlays.default ]; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
              home-manager.users.jaysa.imports = [ ./home ];
            }
          ];
        };
    in
    {
    formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    nixosConfigurations = nixpkgs.lib.genAttrs [ "aiko" "venus" ] mkHost;
    };
}
