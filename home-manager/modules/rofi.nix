{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "Droid Sans Mono 14";
    location = "center";
    terminal = "\${pkgs.wezterm}/bin/wezterm";
    theme = "/run/current-system/sw/share/rofi/themes/arthur.rasi";
    extraConfig = {
        modi = "run,ssh,drun,keys,emoji";
        show-icons = true;
        lines = 5;
    };
  };
}

