{ config, pkgs, ... }:
{
  # Install misc tools, utils and fonts without configuration
  home.packages = with pkgs; [
    any-nix-shell
    cachix
    dmidecode
    figlet
    file
    fzf
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
    ripgrep
    screenfetch
    spacevim
    tmate
    tree
    unrar
    unzip
		vim
    wget
  ];
}
