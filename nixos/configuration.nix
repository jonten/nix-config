# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./thinkpad-x220.nix
      #./observability.nix
      #./kubernetes.nix
      #./nextcloud.nix
      #./kde.nix
    ];

  # Extra options to protect nix-shell from garbage collection
  #nix.extraOptions = ''
  #  keep-outputs = true
  #  keep-derivations = true
  #'';

  # Use latest kernel for desktop use
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.copyKernels = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.zfs.enableUnstable = true;
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoSnapshot.enable = false;
  services.zfs.autoScrub.enable = true;

  # Backup system configs
  system.copySystemConfiguration = true;

  # Set hardware clock to localtime
  #time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Stockholm";

  # Adding udev rules for ZTE MF880 modem
  #services.udev.packages = [ "/run/current-system/sw/bin/usb_modeswitch" ];
  #ATTRS{idVendor}=="19d2", ATTRS{idProduct}=="0166", RUN+="usb_modeswitch '%b/%k'"
  #services.udev.extraRules = ''
  #  ATTRS{idVendor}=="19d2", ATTRS{idProduct}=="0166", ENV{.MM_USBIFNUM}=="04", ENV{ID_MM_ZTE_PORT_TYPE_MODEM}="1"
  #  ATTRS{idVendor}=="19d2", ATTRS{idProduct}=="0166", ENV{.MM_USBIFNUM}=="01", ENV{ID_MM_ZTE_PORT_TYPE_AUX}="1"
  #'';

  networking.hostId = "ea476e92";

  networking.hostName = "nixbox"; # Define your hostname.
  # Disable IPv6 support
  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" "nohibernate" ];

  # Provide networkmanager for easy wireless configuration.
  networking.networkmanager.enable = true;
  services.dbus.enable = true;
  networking.wireless.enable = false;

  # KDE complains if power management is disabled (to be precise, if
  # there is no power management backend such as upower).
  #powerManagement.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "lat9w-16";
    keyMap = "fi";
  };



  # Allow unfree packages to be installed
  #allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    actkbd
    bind
    cabextract
    calibre
    cifs_utils
    ctags
    cups
    cups-filters
    cups-pk-helper
    docker
    docker_compose
    dunst
    duplicati
    ecryptfs
    element-desktop
    ephemeral
    etherape
    exfat
    exfat-utils
    feh
    ffmpeg
    font-awesome-ttf
    fuse_exfat
    gimp
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    gnomeExtensions.hotkeys-popup
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.force-quit
    gnomeExtensions.hide-top-bar
    gnomeExtensions.media-controls
    gnomeExtensions.mute-spotify-ads
    gnomeExtensions.no-overview
    gnomeExtensions.nothing-to-say
    gnomeExtensions.sermon
    gnomeExtensions.vitals
    gnomeExtensions.just-perfection
    gnomeExtensions.logo-menu
    gnome.gnome-boxes
    gnupg
    gpgme
    guake
    gutenprint
    i3
    i3blocks
    i3cat
    i3lock
    i3minator
    i3status
    kbfs
    keepassx
    keybase
    keybase-gui
    libreoffice-fresh
    libxfs
    liferea
    linuxPackages.virtualbox
    linuxPackages.virtualboxGuestAdditions
    lxqt.lximage-qt
    #mate.mate-notification-daemon
    #mobile_broadband_provider_info
    mp4v2
    #nasc
    #nix-index
    #nixops
    openbox
    openshot-qt
    opensnitch
    opensnitch-ui
    #pantheon.elementary-session-settings
    #pantheon-tweaks
    parted
    #pkgconfig
    #poedit
    pop-gtk-theme
    pop-icon-theme
    powerline-fonts
    powerline
    #ppp
    pwsafe
    #qutebrowser
    rclone
    smartmontools
    srm
    sshpass
    st
    #syncthing
    tootle
    tor-browser-bundle-bin
    torrential
    transmission_gtk
    #ulauncher
    unrar
    unzip
    usb_modeswitch
    vagrant
    #vimHugeX
    #vimPlugins.Solarized
    virt-manager
    vivaldi
    vlc
    vscode
    whois
    wireshark-qt
    xfsprogs
    xorg.xbacklight
    xorg.xkill
    zeal
    zinit
    zip
  ];

    #shellInit = ''
    #export GTK_PATH=$GTK_PATH:${pkgs.oxygen_gtk}/lib/gtk-2.0
    #export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.oxygen_gtk}/share/themes/oxygen-gtk/gtk-2.0/gtkrc
    #'';

  nixpkgs.config = {

    # add .nix filetype detection and minimal syntax highlighting support
    ftNixSupport = [ "vim" "ftNix" ] true;

    allowUnfree = true;

    allowBroken = true; 

  };

  # Setting up firejail for web browsers etc
  #programs.firejail.enable = true;
  #programs.firejail.wrappedBinaries = {
  #  firefox = {
  #    executable = "${lib.getBin pkgs.firefox}/bin/firefox";
  #    profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
  #  };
  #  chromium = {
  #    executable = "${lib.getBin pkgs.chromium}/bin/chromium";
  #    profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
  #  };
  #  brave = {
  #    executable = "${lib.getBin pkgs.brave}/bin/brave";
  #    profile = "${pkgs.firejail}/etc/firejail/brave.profile";
  #  };
  #  vivaldi = {
  #    executable = "${lib.getBin pkgs.vivaldi}/bin/vivaldi";
  #    profile = "${pkgs.firejail}/etc/firejail/vivaldi.profile";
  #  };
  #  discord = {
  #    executable = "${lib.getBin pkgs.discord}/bin/discord";
  #    profile = "${pkgs.firejail}/etc/firejail/discord.profile";
  #  };
  #};

  # Adding trusted binary cache
  nix.trustedBinaryCaches = [ "http://hydra.nixos.org" ];

  # Adding trusted binary cache users
  nix.trustedUsers = [ "root" "xxx" ];

  # Add ZSH Shell
  programs.zsh.enable = true;

  # Add fonts
  
   fonts = {
     fontDir.enable = true;
     enableGhostscriptFonts = true;
     fonts = with pkgs; [
       corefonts  # Micrsoft free fonts
       inconsolata  # monospaced
       ubuntu_font_family  # Ubuntu fonts
     ];
   };

 
  # List services that you want to enable:
  
  # Enable virtualbox service
  virtualisation.virtualbox.host.enable = true;

  # Libvirt, QEMU, KVM support
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  networking.firewall.checkReversePath = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "se";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.enableCtrlAltBackspace = true;

  # Enable Synaptics touchpad
  services.xserver.synaptics.enable = false;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.slim.enable = true;
  ###services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.plasma5.enableQt4Support = true;
  #services.xserver.desktopManager.plasma5.extraPackages = [];
  #services.xserver.windowManager.awesome.enable = true;
  #services.xserver.desktopManager.enlightenment.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraSessionCommands = "";
  #services.xserver.windowManager.openbox.enable = true;
  services.xserver.desktopManager.pantheon.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.lightdm.greeters.pantheon.enable = false;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  
  #services.xserver.desktopManager.gnome.flashback.customSessions = [
  #  {
  #    wmName = "i3";
  #    wmLabel = "i3";
  #    wmCommand = "${pkgs.i3}/bin/i3";
  #    enableGnomePanel = false;
  #  }
  #]; 

  # Enable Syncthing service
  #services.syncthing.dataDir = "/home/xxx/.config/syncthing";
  #services.syncthing.enable = true;  
  #services.syncthing.user = "xxx";  
  #services.syncthing.systemService = true;

  # Enable Hashicorp Vault
  #services.vault.enable = true;
  #services.vault.address = "http://127.0.0.1:8200";
  #services.vault.storageBackend = "file";
  #services.vault.storagePath = "/var/lib/vault";

  # Enable Flatpak service
  #services.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable Docker service
  virtualisation.docker.enable = true;
  #virtualisation.docker.storageDriver = "zfs";
  virtualisation.docker.storageDriver = "devicemapper";

  # Enable keybase and kbfs
  services.kbfs.enable = true;
  services.kbfs.enableRedirector = false;
  services.kbfs.mountPoint = "/%h/keybase";
  #services.kbfs.extraFlags = [ "-label kbfs" "-mount-type normal" ];
  services.keybase.enable = true;

  # Enable Opensnitch application firewall
  services.opensnitch.enable = true;

  # Enable CUPS to print documents.
  #let
  #  pkgs = pkgs.callPackage ../../home/xxx/source/git/nixpkgs/pkgs/misc/cups/drivers/brother/dcpl3550cdw/default.nix {};
  #in
  services.printing = {
    enable = true;
    drivers = with pkgs; [
    #drivers = [
      #dcpl3550cdwcupswrapper
      #dcpl3550cdwdrv
      #brgenml1cupswrapper
      #brgenml1lpr
      #brlaser
      mfcl3770cdwlpr
      mfcl3770cdwcupswrapper
      #dcpl3550cdwdrv
      #dcpl3550cdwcupswrapper
    ];
  };

  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

  # Enable Duplicati backup service
  #services.duplicati = {
  #  port = 8200;
  #  user = "duplicati";
  #  interface = "127.0.0.1";
  #  enable = true;
  #};


  #users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with passwd 
   users.extraUsers.xxx = {
     isNormalUser = true;
     name = "xxx";
     group = "users";
     description = "xxx";
     extraGroups = [ "wheel" "networkmanager" "vboxusers" "dialout" "docker" "adm" "libvirtd" "video" ];
     shell = pkgs.zsh;
     useDefaultShell = false;
     #uid = 1000;
     createHome = true;
     home = "/home/xxx";
  };

  # Start ssh-agent and add keys valid for 8 hours
  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = "8h";

  # ClamAV settings
  #services.clamav = {
  #  updater.enable = true;
  #  daemon.enable = true;
  #  updater.interval = "daily";
  #};

}
