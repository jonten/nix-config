{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kbfs
    keybase
    keybase-gui
  ];
  systemd.user.services = {
    services.keybase.enable = true;
    services.kbfs.enable = true;
  };
  systemd.user.startServices = "sd-switch";
}
