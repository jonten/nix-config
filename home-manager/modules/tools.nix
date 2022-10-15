{ config, pkgs, ... }:
{
  # Install misc tools and utils without configuration
  home.packages = with pkgs; [
    any-nix-shell
    cachix
    cdrkit
    dmidecode
    dogdns
    effitask
    exa
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
    tmate
    todofi-sh
    todiff
    todo-txt-cli
    tree
    unrar
    unzip
    wget
  ];
}
