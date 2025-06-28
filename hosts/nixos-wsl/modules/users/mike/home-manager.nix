# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  ...
}:

{
  # You can import other home-manager modules here
  imports = [
    ./programs/git.nix
  ];

  # Enable home-manager in this user profile
  programs = {
    home-manager = {
      enable = true;
    };

  };

  # Nicely reload system units when changing configs
  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home = {
    # This should be the same as your packages version (usually)
    stateVersion = "25.05";
  };
  
}