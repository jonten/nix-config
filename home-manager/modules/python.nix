{ config, pkgs, ... }:
{
  # Install Python and misc libraries
  home.packages = with pkgs; [
    python3
    python3Packages.pynvim
  ];
}

