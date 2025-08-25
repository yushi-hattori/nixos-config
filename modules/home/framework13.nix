{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
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
      steam
      kde-rounded-corners
      kdePackages.kcalc
      kdePackages.krohnkite
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
      TERMINAL = "ghostty";
    };
  };
}
