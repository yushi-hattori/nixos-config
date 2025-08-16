{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    opencode = {
      url = "github:sst/opencode/v0.3.58";
      flake = false;
    };

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    plugins-debugmaster = {
      url = "github:miroshQa/debugmaster.nvim";
      flake = false;
    };

    plugins-nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };

    plugins-opencode = {
      url = "github:NickvanDyke/opencode.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-wsl,
    home-manager,
    nixCats,
    opencode,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    # Shared home-manager configuration
    homeManagerConfig = {
      home-manager = {
        extraSpecialArgs = {inherit inputs;};
        useGlobalPkgs = true;
        useUserPackages = true;
        users.yhattori = {
          imports = [./modules/home/default.nix];
        };
      };
    };

    # Fixed overlay for opencode
    opencodeOverlay = (
      {
        config,
        pkgs,
        lib,
        ...
      }: {
        imports = [
          (
            {...}: {
              nixpkgs.overlays = [
                (final: prev: {
                  opencode = nixpkgs-unstable.legacyPackages.${prev.system}.opencode.overrideAttrs (old: {
                    version = "0.3.58";
                    src = opencode;
                    node_modules = old.node_modules.overrideAttrs (nmOld: {
                      outputHash = "sha256-ZMz7vfndYrpjUvhX8L9qv/lXcWKqXZwvfahGAE5EKYo=";
                    });
                    tui = old.tui.overrideAttrs (tuiOld: {
                      vendorHash = "sha256-8OIPFa+bl1If55YZtacyOZOqMLslbMyO9Hx0HOzmrA0=";
                    });
                  });
                })
              ];
            }
          )
        ];
        environment.systemPackages = [pkgs.opencode];
      }
    );
  in {
    nixosConfigurations = {
      framework13 = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/hosts/framework13/configuration.nix
          ./modules/hosts/framework13/hardware-configuration.nix
          ./modules/hosts/default.nix

          # homeManagerConfig
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              users.yhattori = {
                imports = [
                  ./modules/home/default.nix
                  ./modules/home/framework13.nix
                ];
              };
            };
          }

          opencodeOverlay
        ];
      };

      # wsl = lib.nixosSystem {
      #   inherit system;
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     ./modules/hosts/default.nix
      #     # ./modules/hosts/wsl.nix
      #     nixos-wsl.nixosModules.default
      #     {
      #       wsl.enable = true;
      #       wsl.defaultUser = "yhattori";
      #     }
      #     home-manager.nixosModules.home-manager
      #     homeManagerConfig
      #     {
      #       nixpkgs.overlays = [ opencodeOverlay ];
      #       environment.systemPackages = [ nixpkgs.opencode ];
      #     }
      #   ];
      # };
    };
  };
}
