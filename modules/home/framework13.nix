{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./default.nix
    ../../programs/easyeffects.nix
    ../../programs/zen-browser.nix
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # Optional: specify settings here or use a separate config file
    # settings = {
    #   # Your hyprland configuration
    # };
  };

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
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
      TERMINAL = "ghostty";
    };
  };
}
