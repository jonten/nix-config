{ pkgs, config, modulesPath, ...}:
{
  environment.systemPackages = with pkgs; [
    quassel
    yakuake
    ktorrent
    kgpg
    konsole
    #dolphin-plugins
    #kio-extras
    kolourpaint
    #kompare
    #krfb
    #kwalletmanager
    okular
    ark
    gwenview
    filelight
    kcalc
    kate
    kakoune
    kcolorchooser
    krusader
    kompare
    krename
    kget
  ];
}
