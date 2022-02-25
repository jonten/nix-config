{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow non-free applications
  nixpkgs.config.allowUnfree = true;

  # Allow some insecure applications
  nixpkgs.config.permittedInsecurePackages = [ "electron-9.4.4" ];

  # Install and activate nix-direnv
  #programs.direnv.enable = true;
  #programs.direnv.enableNixDirenvIntegration = true;
  # Extra options to protect nix-shell against garbage collection
  #keep-outputs = true;
  #keep-derivations = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${builtins.getEnv("USER")}";
  home.homeDirectory = "${builtins.getEnv("HOME")}";
  home.sessionVariables = { EDITOR = "vim"; };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Import install and configs for various apps
  imports = [
    ./modules/apps.nix
    ./modules/chromium.nix
    ./modules/cloud.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/golang.nix
    ./modules/kubie.nix
    ./modules/neovim.nix
    ./modules/python.nix
    ./modules/rofi.nix
    ./modules/rust.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/tools.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
  ];
}
