{ config, pkgs, ... }:
{
  # Install Rust (rustup) and other misc libraries
  home.packages = with pkgs; [
    rustup
  ];
}
