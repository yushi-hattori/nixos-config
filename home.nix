{ config, pkgs, inputs, lib, ... }: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    ./programs/default.nix
  ];

  home = {
    username = "yhattori";
    homeDirectory = "/home/yhattori";
    stateVersion = "24.11";
    packages = with pkgs; [
      neofetch
      nnn # terminal file manager
      zoxide
      git
      # utils
      ripgrep # recursively search directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      # yq-go # yaml processor https://github.com/mikefarah/yq
      eza # a modern replacement for 'ls'
      fzf # a command-line fuzzy finder
      zoxide
      xclip
    ];
  };

# Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
