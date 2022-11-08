{ config, pkgs, ... }:
{
  # Install misc cloud, IaC and virtualisation tools without configuration
  home.packages = with pkgs; [
    google-cloud-sdk
    k3s
    k9s
    kind
    kpt
    kubecolor
    kubectl
    #kubectx
    #kubeprompt
    kubernetes-helm
    kustomize
    minikube
    packer
    terraform
    terraform-providers.google
    terraform-providers.github
    terraform-providers.local
  ];
}
