{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: 
  {
    # Builds the nixos host -> `Use sudo nixos-rebuild switch --flake .`
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        nixos-wsl.nixosModules.default
	{
	  system.stateVersion = "24.11";
	  wsl.enable = true;
	}
        # ./configuration.nix
      ];
    };
  };
}
