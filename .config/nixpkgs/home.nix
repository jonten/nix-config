{ config, pkgs, ... }:
#{ config, pkgs, hostName ? "unknown", ...}:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow non-free applications
  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  # Install and activate nix-direnv
  #programs.direnv.enable = true;
  #programs.direnv.enableNixDirenvIntegration = true;
  # Extra options to protect nix-shell against garbage collection
  #keep-outputs = true;
  #keep-derivations = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jonte";
  home.homeDirectory = "/home/jonte";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  #imports =
  #  if (hostName == "foobar" || hostName == "barfoo")
  #    then [
  #      ../nix/fish.nix
  #      ../nix/git.nix
  #      ../nix/tmux.nix
  #      ../nix/vim.nix
  #    ]
  #    else [];
  home.packages = with pkgs; [
    # Basic tools
    bats
    cachix
    figlet
    file
    htop
    inconsolata-nerdfont
    jq
    nerdfonts
    niv
    nix-bash-completions
    nix-prefetch-scripts
    nox
    ripgrep
    starship
    tmate
    tree
    unzip
    wget

    # nvim, and its runtime dependencies
    #(callPackage ../nix/nvim {})
  ];

}
