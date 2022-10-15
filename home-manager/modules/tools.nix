{ config, pkgs, ... }:
{
  # Install misc tools and utils without configuration
  home.packages = with pkgs; [
    any-nix-shell
    cachix
    dmidecode
    figlet
    file
    fzf
    htop
    httpie
    jq
    lsof
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
