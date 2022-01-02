{config, pkgs, ...}:
{

# Setting hostname
networking.extraHosts = "127.0.0.1 nextcloud.home.lan";

# Open Firewall ports
networking.firewall.allowedTCPPorts = [ 80 443 ];

# Enable LetsEncrypt certificates
#security.acme = {
#    acceptTerms = true;
#    # Replace the email here!
#    email = "test@example.com";
#};

# Enable Nginx
services.nginx = {
    enable = true;
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    #recommendedTlsSettings = true;
    recommendedTlsSettings = false;

 # Only allow PFS-enabled ciphers with AES256
    #sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

# Setup Nextcloud virtual host to listen on ports
 virtualHosts = {

     "nextcloud.home.lan" = {
       ## Force HTTP redirect to HTTPS
       #forceSSL = true;
       forceSSL = false;
       ## LetsEncrypt
       #enableACME = true;
    };
  };
};

# Actual Nextcloud Config
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.home.lan";
    # Enable built-in virtual host management
    # Takes care of somewhat complicated setup
    # See here: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/web-apps/nextcloud.nix#L529

    # Use HTTPS for links
    #https = true;
    https = false;
    
    # Auto-update Nextcloud Apps
    autoUpdateApps.enable = true;
    # Set what time makes sense for you
    autoUpdateApps.startAt = "05:00:00";

    config = {
      # Further forces Nextcloud to use HTTPS
      overwriteProtocol = "http";

      # Nextcloud PostegreSQL database configuration, recommended over using SQLite
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "/var/nextcloud-db-pass";

      adminpassFile = "/var/nextcloud-admin-pass";
      adminuser = "admin";
 };
};

# Enable PostgreSQL 
  services.postgresql = {
    enable = true;

    # Ensure the database, user, and permissions always exist
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
     { name = "nextcloud";
       ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
     }
    ];
  };

  # Ensure that postgres is running before running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
