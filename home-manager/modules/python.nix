{ config, pkgs, ... }:
{
  # Install Python and misc libraries
  home.packages = with pkgs; [
    python39
    python39Packages.pip
    virtualenv
  ];
}

