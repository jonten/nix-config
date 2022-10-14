{ config, pkgs, ... }:
{ 
   home.packages = with pkgs; [
    gopls
    delve
  ];
  programs.go = {
    enable = true;
    package = pkgs.go;
  };
}



