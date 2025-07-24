{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./bash.nix
    ./lazygit.nix
    ./nixCats/default.nix
    ./zellij.nix
    ./zsh.nix
    ./zoxide.nix
    ./spotify-player.nix
    ./opencode.nix
  ];
}
