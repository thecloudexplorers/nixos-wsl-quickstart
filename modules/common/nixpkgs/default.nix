{
  lib,
  ...
}:

{
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    # Allow unfree packages.
    config = {
      allowUnfree = true;
    };
  };
  
}