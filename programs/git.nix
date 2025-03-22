{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "yhattori";
    userEmail = "yushi.t.hattori@gmail.com";
  };
}
