{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi-calc
    rofi-emoji
    rofi-power-menu
    rofi-rbw
    rofi-systemd
    rofi-vpn
  ];
  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 14";
    location = "center";
    terminal = "\${pkgs.wezterm}/bin/wezterm";
    theme = "arthur";
    extraConfig = {
        modi = "window,run,ssh,drun,keys,combi";
        combi-modi = "drun,emoji,calc,window,keys";
        show-icons = true;
        lines = 5;
    };
  };
}

