{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/e0ed589d7422c1d7a1bdd1e81289e2428c6ec2a3.tar.gz") {}, config, ... }:
{
  home.packages = with pkgs; [
    nerdfonts
    inconsolata-nerdfont
  ];
}

