{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = "";
    historyLimit = 10000;
    secureSocket = true;
    shell = "\${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
  };
}

