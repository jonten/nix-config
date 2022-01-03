{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "Droid Sans Mono 22";
    plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];
    cycle = true;
    theme = "fancy";
    extraConfig = {
        modi = "window,run,ssh,drun,keys,calc,emoji";
        combi-modi = "window,drun,ssh";
        show-icons = true;
        lines = 5;
    };
  };
}

