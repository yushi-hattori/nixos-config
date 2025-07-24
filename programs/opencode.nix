{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    history = {
      append = true;
      extended = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      "cd" = "z";
      ".." = "cd ..";
      "gc" = "sudo nix-collect-garbage -d";
      "update" = "sudo nixos-rebuild switch --flake ~/nixos-config/flake.nix";
      "ls" = "eza";
      grep = "grep --color=auto";
    };
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      if [ -f "$HOME/.env" ]; then
        set -a
        source "$HOME/.env"
        set +a
      fi

      bindkey '^E' autosuggest-accept  # Ctrl + e to accept autosuggestions
      bindkey '^J' history-down        # Ctrl + j to move down in history
      bindkey '^K' history-up          # Ctrl + k to move up in history

    '';

    oh-my-zsh = {
      enable = true;
      theme = "sorin";
      plugins = [
        "git"
        "sudo"
        "docker"
        "thefuck"
      ];
    };
  };
}
