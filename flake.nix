{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-nixcats = {
      url = "github:BirdeeHub/nixCats-nvim?dir=templates/example";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: 
  {
    # Builds the nixos host -> `Use sudo nixos-rebuild switch --flake .`
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	# ./modules/nixCats/default.nix
        nixos-wsl.nixosModules.default
	{
	  system.stateVersion = "24.11";
	  wsl.enable = true;
	  wsl.defaultUser = "yhattori";
	}

	home-manager.nixosModules.home-manager 
	{
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.yhattori = import ./home.nix;
	  };
	}
      ];
    };
  };
}
