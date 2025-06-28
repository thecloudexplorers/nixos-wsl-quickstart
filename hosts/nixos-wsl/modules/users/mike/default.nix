{
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
# Use of let/in will greatly enhance dynamic configurations
let
  # Ensure the homeManager is referenced for use here
  homeManager = inputs.home-manager.nixosModules.default;
in
{
  imports = [
    # Import home-manager's NixOS module
    homeManager
  ];

  # While the `users.users.*` configuration allows basic
  # configuration of the user. Home Manager allows for very
  # granular configuration of users at an option level
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      mike = import ./home-manager.nix;
    };
  };

  users = {
    users = {
      mike = {
        name = "mike";
        # You *can* change the user ID, even of default users
        # just be aware it can be a bit finnicky. You can't
        # really mess it up though, as the build will succeed
        # and just throw a warning if the ID cannot be changed
        uid = lib.mkForce 1047;
        description = "Mike";
        home = "/home/mike";
        group = "users";
        # If you want to ensure your users have a default password
        # this will do it. Free to change at any time using `passwd`
        # from commandline and the initial password will not be
        # re-inforced afterwards
        initialPassword = "ChangeMe01!";
        createHome = true;
        homeMode = "700";
        isSystemUser = false;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
          "nix-admin"
          "acme"
          "ssl-cert"
        ];
        # This is where you *install* programs, instead of apt-get
        # by declaration. Use the NixOS search page to find more:
        # https://search.nixos.org/packages
        packages = with pkgs; [
          nix-search-cli
          nixos-generators
          (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
              jnoortheen.nix-ide
              redhat.vscode-yaml
              yzhang.markdown-all-in-one
              ms-python.python
              ms-vscode.powershell
            ];
          })
        ];
      };
    };
  };
    
}