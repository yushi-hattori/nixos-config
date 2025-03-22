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

  users.users.yhattori = {
    isNormalUser = true;
    home = "/home/yhattori";
    extraGroups = [ "wheel" "networkmanager" ];
  }; 
}
