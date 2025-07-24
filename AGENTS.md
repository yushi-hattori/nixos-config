# AGENTS

## Build & Activation
- sudo nixos-rebuild switch --flake .#nixos
- nix build .#homeConfigurations.yhattori.activationPackage
- home-manager switch --flake .#yhattori
- nix flake update | nix flake check

## Lint & Formatting
- nix fmt .
- stylua .
- taplo fmt

## Testing
- nix flake check
- nix build .#checks.<test-name> (single test)

## Code Style Guidelines
- Nix: 2-space indent, braces on same line; run nix fmt.
- Lua: snake_case; run stylua.
- KDL/TOML: format with kdlfmt/taplo.
- Imports: group related inputs/overlays at top.
- Errors: prefer guard patterns; use builtins.error for fatal.
