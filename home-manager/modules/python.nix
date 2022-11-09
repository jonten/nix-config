{ config, pkgs, ... }:
{
  # Install Python and misc libraries
  home.packages = with pkgs; [
    python310Full
    python310Packages.pip
    python310Packages.pynvim
    python310Packages.pre-commit-hooks
  ];
}

