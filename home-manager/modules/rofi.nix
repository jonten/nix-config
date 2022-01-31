{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 14";
    location = "center";
    terminal = "\${pkgs.wezterm}/bin/wezterm";
    theme = "arthur";
    extraConfig = {
        modi = "window,run,ssh,drun,keys";
        combi-modi = "window,drun";
        show-icons = true;
        lines = 5;
    };
  };
}

