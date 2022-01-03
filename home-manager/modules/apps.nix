{ config, pkgs, ... }:
{
  # Install misc apps without configuration
  home.packages = with pkgs; [
    authy
    bitwarden
    brave
    discord
    element-desktop
    gimp
    guake
    lens
    libreoffice-fresh
    liferea
    maestral
    maestral-gui
    obsidian
    signal-cli
    signal-desktop
    slack
    spotify
  ];
}
