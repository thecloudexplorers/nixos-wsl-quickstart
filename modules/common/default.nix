{
  config,
  ...
}:

{
  imports = [
    ./environment
    ./nix
    ./nixpkgs
    ./programs
    ./system
    ./users
  ];

}