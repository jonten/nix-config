{ config, pkgs, ... }:
{
  # Install misc apps without configuration
  home.packages = with pkgs; [
    _1password
    _1password-gui
    authy
    bitwarden
    brave
    element-desktop
    gimp
    lens
    libreoffice-fresh
    maestral
    maestral-gui
    marker
    newsflash
    obinskit
    obsidian
    pinta
    remmina
    simplescreenrecorder
    slack
    tabnine
    vivaldi
    whatsapp-for-linux
    zoom-us
  ];
}
