# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # This is where you import additional configuration files as desired
  ];

  # All `wsl.*` options are specific to NixOS-WSL, and will not be
  # needed if you create configurations for other hosts

  # This needs to be enabled for the nixos-rebuild command to be
  # instructued to include the required packages and config for WSL
  wsl.enable = true;
  # The default user can be any user you prefer. Just ensure
  # you follow the specific steps before you can this from the
  # default user, `nixos`
  wsl.defaultUser = "nixos";
  
  # To get you familiar with NixOS Configurations, just learn that
  # you can change the hostname with the following options
  networking = {
    # By default nixos install with `nixos` as a hostname. Change
    # this to whatever hostname you prefer. Using `nixos-wsl` here
    # to demonstrate a change from the default image
    hostName = "nixos-wsl";
  };

  # The users option adds and configures (any number of) users and
  # user related options, such as groups
  users = {
    # This ensures you can change the password of the users
    mutableUsers = true;
    
    # You define user groups under `users.groups.*` as demonstrated
    # here with this option
    groups = {
      # Maybe you want to change acme (Let's Encrypt?) options then
      # you might want to give your user access to acme folders
      # using the group defined here. Although I am not configuring
      # a Let's Encrypt certbot like package here, demonstrating
      # how to set a group based off of that package anyway
      acme = {
        name = "acme";
        # If you prefer, you can manually set group (and user) ID's
        # which will help with specific settings
        gid = 991;
      };
    };

    # `users.users.*` is the collection of users under the users
    # option. Yes, that is the specific naming convention here
    users = {
      # Just like with groups, this is a distinct user. You can
      # create any number of users you prefer, or as in this case
      # (re)configure the default `nixos` user however you want
      nixos = {
        name = "nixos";
        description = "NixOS";
        home = "/home/nixos";
        # In general it is good practice to have the `users` group
        # be the default group, and add additional ones under
        # the `extraGroups` option
        group = "users";
        createHome = true;
        homeMode = "700";
        # If creating users to function as service accounts, use
        # the system user option. These options are mutually
        # exclusive, and the nixos build will remind you of that
        isSystemUser = false;
        isNormalUser = true;
        
        # Add any number of additional groups you need. The `wheel`
        # group ensures your user can `sudo` for administrative
        # elevation
        extraGroups = [
          "networkmanager"
          "wheel"
          "acme"
        ];

        # This is where you *install* programs, instead of apt-get
        # by declaration. Use the NixOS search page to find more:
        # https://search.nixos.org/packages
        packages = with pkgs; [
          # You wouldn't have to include bash as a package, but
          # including it specifically here to demonstrate a
          # basic package without anything fancy like overrides
          bash
          # Using VSCode, with Codium override, as a demonstration
          # of how packages work with extentions as well
          (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
              # This extention will get you Nix support
              # by default in VSCode/Codium
              jnoortheen.nix-ide
              # Further extensions added as example only,
              # but feel free to pick any preferred
              # packages part of your usual setup
              redhat.vscode-yaml
              yzhang.markdown-all-in-one
              ms-python.python
              ms-vscode.powershell
              # Find the correct ID's from the VSCode
              # marketplace here:
              # https://marketplace.visualstudio.com/vscode
            ];
          })
        ];

      };
    };
  };

}