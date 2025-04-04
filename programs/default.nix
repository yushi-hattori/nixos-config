{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./bash.nix
    ./nixCats/default.nix
  ];
}
