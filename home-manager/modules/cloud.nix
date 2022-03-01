{ config, pkgs, ... }:
{
  # Install misc cloud, IaC and virtualisation tools without configuration
  home.packages = with pkgs; [
    cloud-custodian
    google-cloud-sdk
    kpt
    kubernetes-helm
    kubecolor
    kubectl
    kubepug
    k9s
    minikube
    packer
    podman
    podman-compose
    popeye
    tfswitch
  ];
}
