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
    feedreader
    gimp
    guake
    imwheel
    lens
    libreoffice-fresh
    maestral
    maestral-gui
    obinskit
    obsidian
    signal-cli
    signal-desktop
    slack
  ];
}
