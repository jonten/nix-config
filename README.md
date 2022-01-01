# nix-config
Nix Home Manager config


You should clone this repo to the root of your $HOME directory

Install home-manager stand alone by following this guide taken from the home-manager page https://nix-community.github.io/home-manager/index.html#sec-install-standalone

1. Make sure you have a working Nix installation. Specifically, make sure that your user is able to build and install Nix packages. For example, you should be able to successfully run a command like nix-instantiate '<nixpkgs>' -A hello without having to switch to the root user. For a multi-user install of Nix this means that your user must be covered by the allowed-users Nix option. On NixOS you can control this option using the nix.allowedUsers system option.
Note that Nix 2.4 is not yet fully supported. Most significantly, Home Manager is incompatible with the new nix profile.

2. Add the appropriate Home Manager channel. If you are following Nixpkgs master or an unstable channel you can run
```
 nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

 nix-channel --update
 ``` 

and if you follow a Nixpkgs version 21.11 channel you can run
```
 nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager

 nix-channel --update
 ```

On NixOS you may need to log out and back in for the channel to become available. On non-NixOS you may have to add
```
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
```
to your shell (see nix#2033).

3. Run the Home Manager installation command and create the first Home Manager generation:
```
 nix-shell '<home-manager>' -A install
```
Once finished, Home Manager should be active and available in your user environment.

4. If you do not plan on having Home Manager manage your shell configuration then you must source the
```
$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
```
file in your shell configuration ($HOME/.profile or $HOME/.zprofile).

5. When you are done installing home-manager you can link to this repo from the home-manager install directory
```
cd $HOME/.config/nixpkgs
ln -sr ../../nix-config/home-manager/home.nix home.nix
ln -sr ../../nix-config/home-manager/nix/nix.conf ../nix/nix.conf 
ln -sr ../../nix-config/home-manager/modules modules
```

6.  Run home-manager either in dry-run mode to see that everything is working or if you feel lucky install everything right away
```
home-manager -n build #Builds everything in dry-run mode
home-manager switch #Or the alias 'hms' installs everything
```
