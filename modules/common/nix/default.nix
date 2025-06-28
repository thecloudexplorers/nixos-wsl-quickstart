{
  ...
}:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = [
        "02:30"
      ];
    };
    
    settings = {
      auto-optimise-store = true;
      allowed-users = [
        "@wheel"
        "@nix-admin"
      ];
      download-buffer-size = 524288000; # Increase buffer size for better remote build performance
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  
}