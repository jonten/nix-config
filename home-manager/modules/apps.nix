{ config, pkgs, ... }:
{
  # Install misc apps without configuration
  home.packages = with pkgs; [
    authy
    bitwarden
    brave
    discord
    lens
    maestral
    maestral-gui
    obsidian
    signal-cli
    signal-desktop
    slack
    spotify
  ];
}
