{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./bash.nix
    ./lazygit.nix
    ./nixCats/default.nix
    ./zellij.nix
  ];
}
