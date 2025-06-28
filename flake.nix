{
  description = "A quickstart flake for using NixOS-WSL. Switch configurations depending on the intended experience level.";

  # Load various input modules to ensure references to the required sources
  inputs = {
    # NOTE: Replace "nixos-YY.MM" with that which is in system.stateVersion
    # of your configuration. You can also use latter versions if you wish
    # to upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Load the community driven NixOS common definitions
    nixos-common.url = "github:thecloudexplorers/nixos-common/main";

    # Enable the use of NixOS-WSL configurations in this flake
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Enable home-manager to be able to define user specific configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ensure loading of VS Code extentions directly from the config
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/master";
  };

  outputs = inputs@{ 
    self,
    nixpkgs,
    nixos-common,
    nixos-wsl,
    ...
  }:
  
  {
    # Implement various configurations in one flake for modular declaration
    nixosConfigurations = {
      # Reference the following name as config during nixos-rebuild
      nixos-wsl-basic = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
	        { config._module.args = { flake = self; }; }
          # Ensure the nixos-wsl module is loaded
          nixos-wsl.nixosModules.default
          # Load nixos-common modules - this small example helps
          # understand how nixos modules work within flakes
          # and is not required for your own flake
          nixos-common.nixosModules.localization-en_nl
          # Load the specific host configuration
          ./hosts/nixos-wsl-basic/configuration.nix
        ];
      };
      # Reference the following name as config during nixos-rebuild
      nixos-wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
	        { config._module.args = { flake = self; }; }
          # Ensure the nixos-wsl module is loaded
          nixos-wsl.nixosModules.default
          # Load nixos-common modules - this small example helps
          # understand how nixos modules work within flakes
          # and is not required for your own flake
          nixos-common.nixosModules.localization-en_nl
          # Load the specific host configuration
          ./hosts/nixos-wsl/configuration.nix
        ];
      };
      # Add your own configurations here and then execute the command:
      # `sudo nixos-rebuild --flake /path/to/flake#your-configuration-name`
    };
  };
}
