{ config, pkgs, ... }:
{
  # Install misc cloud, IaC and virtualisation tools without configuration
  home.packages = with pkgs; [
    google-cloud-sdk
    kubectl
    kubectx
    k9s
    minikube
    packer
    terraform
    terraform-providers.google
    terraform-providers.github
    terraform-providers.local
    #terraform-providers.nixos
  ];
}
