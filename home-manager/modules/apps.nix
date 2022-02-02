{ config, pkgs, ... }:
{
  # Install misc apps without configuration
  home.packages = with pkgs; [
    authy
    bitwarden
    brave
    discord
    lens
    lxappearance
    maestral
    maestral-gui
    obsidian
    qownnotes
    signal-cli
    signal-desktop
    slack
    spotify
  ];
}
