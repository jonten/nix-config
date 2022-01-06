{ config, pkgs, ... }:
{
  # Install misc apps without configuration
  home.packages = with pkgs; [
    _1password
    _1password-gui
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
