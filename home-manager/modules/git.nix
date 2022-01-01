{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    ignores =  [ "*~" "*.swp" "*.tmp" "*.crt" "*.key" "*.pem" ".netrc" ];
    userName = "Jon Norman";
    #userEmail = "";
  };
}


