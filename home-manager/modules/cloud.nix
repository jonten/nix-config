{ config, pkgs, ... }:
{
  # Install misc cloud, IaC and virtualisation tools without configuration
  home.packages = with pkgs; [
    cloud-custodian
    k9s
    kpt
    krew
    kubernetes-helm
    kubecolor
    kubepug
    minikube
    packer
    popeye
    skaffold
    terraform-docs
    terrascan
    tflint
    tfsec
    tfswitch
  ];
}
