{pkgs, ...}: {
  imports = [
    ./programs/default.nix
  ];

  home = {
    username = "yhattori";
    homeDirectory = "/home/yhattori";
    stateVersion = "25.05";
    packages = with pkgs; [
      neofetch
      nnn # terminal file manager
      zoxide
      git
      ripgrep # recursively search directories for a regex pattern
      yq-go
      jq # A lightweight and flexible command-line JSON processor
      eza # a modern replacement for 'ls'
      fzf # a command-line fuzzy finder
      zoxide
      xclip
      zsh-vi-mode
      thefuck
      aider-chat
      nix-prefetch-github
    ];
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
