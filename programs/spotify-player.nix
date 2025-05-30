{...}: {
  programs."spotify-player" = {
    enable = true;
  };

  xdg.configFile."spotify-player" = {
    source = ../assets/spotify-player;
    recursive = true;
  };
}
