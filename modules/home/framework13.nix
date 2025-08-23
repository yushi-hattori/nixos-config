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

  programs.quickshell = {
    enable = true;
    package = inputs.caelestia-shell.packages.${pkgs.system}.default.override {withCli = true;};
    systemd.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # Optional: specify settings here or use a separate config file
    # settings = {
    #   decoration = {
    #     shadow_offset = "0 5";
    #     "col.shadow" = "rgba(00000099)";
    #   };
    #
    #   "$mod" = "SUPER";
    #
    #   bindm = [
    #     # mouse movements
    #     "$mod, mouse:272, movewindow"
    #     "$mod, mouse:273, resizewindow"
    #     "$mod ALT, mouse:272, resizewindow"
    #   ];
    # };
    # plugins = [
    #   pkgs.hyprlandPlugins.PLUGIN_NAME
    # ];
    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.PLUGIN_NAME
    # ];
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
