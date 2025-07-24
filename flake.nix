{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode = {
      url = "github:sst/opencode/v0.3.58";
      flake = false;
    };

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # pkgs = nixpkgs.legacyPackages.${system};
  in {
    # nixpkgs.overlays = inputs.<repo-name>.overlays.default;
    # Builds the nixos host -> `Use sudo nixos-rebuild switch --flake .`
    nixosConfigurations."nixos" = lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./modules/hosts/default.nix
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "25.05";
          wsl.enable = true;
          wsl.defaultUser = "yhattori";
        }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useGlobalPkgs = true;
            useUserPackages = true;
            users.yhattori = {
              imports = [
                ./modules/home/default.nix
              ];
            };
          };
        }

        (
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
        )
      ];
    };
  };
}
