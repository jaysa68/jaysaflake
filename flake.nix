{
  description = "jaysa nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.aiko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/aiko
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
	  home-manager.users.jaysa.imports = [ ./home ] ;
	}
      ];
    };
  };
}
