{
  description = "jaysa nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      nixvim,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      nixosConfigurations.aiko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/aiko
          { nixpkgs.overlays = [ nur.overlays.default ]; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
            home-manager.users.jaysa.imports = [ ./home ];
          }
        ];
      };
      nixosConfigurations.venus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/venus
          { nixpkgs.overlays = [ nur.overlays.default ]; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
            home-manager.users.jaysa.imports = [ ./home ];
          }
        ];
      };
    };
}
