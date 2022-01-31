{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    ignores =  [ "*~" "*.swp" "*.tmp" "*.crt" "*.key" "*.pem" ".netrc" "git.nix" ];
    userName = "Jon Norman";
    userEmail = "jon.norman@soundtrackyourbrand.com";
  };
}


