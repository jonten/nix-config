{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    extensions = [
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.vscodevim.vim
      pkgs.vscode-extensions.eamodio.gitlens
      pkgs.vscode-extensions.scala-lang.scala
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.dhall.dhall-lang
      pkgs.vscode-extensions.dhall.vscode-dhall-lsp-server
      pkgs.vscode-extensions.hashicorp.terraform
      pkgs.vscode-extensions.usernamehw.errorlens
      pkgs.vscode-extensions.timonwong.shellcheck
      pkgs.vscode-extensions.graphql.vscode-graphql
      pkgs.vscode-extensions.bbenoist.nix
      pkgs.vscode-extensions.arrterian.nix-env-selector
      pkgs.vscode-extensions.foam.foam-vscode
      pkgs.vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
      pkgs.vscode-extensions.jdinhlife.gruvbox
      pkgs.vscode-extensions.tabnine.tabnine-vscode
    ];
  };
}

