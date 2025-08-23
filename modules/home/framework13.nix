{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./default.nix
    ../../programs/easyeffects.nix
    ../../programs/zen-browser.nix
  ];

  home = {
    packages = with pkgs; [
      ghostty
      # vivaldi
      udiskie
      (discord.override {
        withOpenASAR = true;
        withVencord = false;
      })
      spotify
      obsidian
      obs-studio
      tree
      gparted
      gimp
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
      TERMINAL = "ghostty";
    };
  };
}
