{pkgs, ...}: {
  imports = [
    # ../../programs/default.nix
    ./default.nix
  ];

  home = {
    packages = with pkgs; [
      ghostty
      vivaldi
      udiskie
      (discord.override {
        withOpenASAR = true;
        withVencord = false;
      })
      spotify
      easyeffects
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
      TERMINAL = "ghostty";
    };
  };
}
