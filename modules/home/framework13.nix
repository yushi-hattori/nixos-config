{pkgs, ...}: {
  imports = [
    # ../../programs/default.nix
  ];

  home = {
    packages = with pkgs; [
      ghostty
      vivaldi
      udiskie
      (discord.override {
        withVencord = true;
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
