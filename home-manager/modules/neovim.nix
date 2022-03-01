{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      #url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      # To use a pinned version and not having to build Neovim everytime you run 'home-manager switch' do:
      # Get the revision by choosing a commit from https://github.com/nix-community/neovim-nightly-overlay/commits/master
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/7ab23810d3844251fef656d7acc4bfbb2c4584bd.tar.gz";
      # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
      sha256 = "0vrjk4bs02dsmzc5r7b4qp9byavlz1bqm0b4f1hbgcf1miq4x19g";
    }))
  ];
  programs.neovim.enable = true;
}
