{ config, pkgs, ... }:
let
  hidpiExtraConfig = if config.custom.hidpi then {
    dpi = 160;
  } else { };
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "Droid Sans Mono 22";
    plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];
    cycle = true;
    theme = "fancy";
    extraConfig = {
        modi = "combi";
        #modi = "window,drun,run,keys,calc,emoji";
        #modi = "window,drun,emoji,calc,run,ssh,combi";
        combi-modi = "drun,emoji,calc,run,ssh,window";
        show-icons = true;
        terminal = "wezterm";
        ssh-command = "{terminal} {ssh-client} {host}";
    };
  };
}

