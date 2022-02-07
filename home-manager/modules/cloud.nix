{ config, pkgs, ... }:
{
  # Install misc cloud, IaC and virtualisation tools without configuration
  home.packages = with pkgs; [
    cloud-custodian
    google-cloud-sdk
    kubernetes-helm
    kubecolor
    kubectl
    kubectx
    kubepug
    k9s
    minikube
    packer
    podman
    podman-compose
    popeye
    terraform
    terraform-providers.google
    terraform-providers.github
    terraform-providers.local
    #terraform-providers.nixos
  ];
}
