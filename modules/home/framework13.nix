{pkgs, ...}: {
  imports = [
    ./default.nix
    ../../programs/easyeffects.nix
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
    ];

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
      TERMINAL = "ghostty";
    };
  };
}
