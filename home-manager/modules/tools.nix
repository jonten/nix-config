{ config, pkgs, ... }:
{
  # Install misc tools, utils and fonts without configuration
  home.packages = with pkgs; [
    any-nix-shell
    cachix
    dmidecode
    figlet
    file
    htop
    httpie
    inconsolata-nerdfont
    jq
    lsof
    nerdfonts
    nix-bash-completions
    nix-prefetch-scripts
    nmap
    nox
    ripgrep-all
    spacevim
    tmate
    tree
    unrar
    unzip
		vim
    wget
  ];
}
