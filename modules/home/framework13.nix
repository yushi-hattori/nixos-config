{pkgs, ...}: {
  imports = [
    # ../../programs/default.nix
  ];

  home = {
    packages = with pkgs; [
      ghostty
    ];
  };
}
