{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./bash.nix
    ./lazygit.nix
    ./nvim/default.nix
    ./zellij.nix
    ./zsh.nix
    ./zoxide.nix
    ./spotify-player.nix
    ./opencode.nix
  ];
}
