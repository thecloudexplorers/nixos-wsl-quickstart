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
    # Instead of having one massive configuration.nix file
    # I prefer to split it into separate files for maintainability
    ./modules/networking
    ./modules/users
    # Common modules can be easily reused by multiple host configurations
    ../../modules/common
    ../../modules/common-desktop
  ];

  wsl.enable = true;
  # I changed my username here, as per my
  # own preference. Just follow the instructions for
  # the default user here:
  # https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  wsl.defaultUser = "mike";

}