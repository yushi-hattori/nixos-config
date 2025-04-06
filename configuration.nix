{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  system.stateVersion = "24.11"; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
  ];
  # Set the default editor to nvim
  environment.variables.EDITOR = "nvim";

  programs.zsh.enable = true;

  users.users.yhattori = {
    isNormalUser = true;
    home = "/home/yhattori";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  }; 
}
