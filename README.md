# NixOS-WSL Quickstart

If you're confortable with using Windows, don't intend to install a full blown Linux distro on your machine (yet), and would like to get a quick environment setup to experiment with NixOS... Look no further!

This repo is intended to help you quickly get setup with an initial NixOS-WSL installation, to explore NixOS from the comfort of Windows (if that is your main driver).

Maybe you fall in love with it and decide to setup a dedicated machine with NixOS... maybe you don't! At least this will lower the threshold to actually start exploring NixOS and make that determination yourself.

## Practical steps

O.K., now how about that quickstart?

- Reference the [NixOS-WSL installation instructions](/docs/nixos-wsl-install.md) to install right away.
  - Take not of the specific instructions for changing your user-name. It is the only part of the process that requires a delicate touch. (Fortunately you can reinstall quickly if you mess it up.)
- Learn about some NixOS basics to get you started with:
  - [NixOS in general](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution)
  - [The Nix Language](https://nix.dev/tutorials/nix-language)
  - [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- Feel free to use the [very basic example configuration](/hosts/nixos-wsl-basic/configuration.nix) in this very repo to help you learn by example.
  - You can use this to get you started without too much complexity.
  - Use this configuration by executing: `sudo nixos-rebuild --flake /path/to/flake#nixos-wsl-basic`
- And finally, use the [flake in this repo](/flake.nix), [with the more modular configuration](/hosts/nixos-wsl/configuration.nix), to help accelerate your learning.
  - The flake references both the basic and the more modular configuration files.
  - Use the modular configuration by executing: `sudo nixos-rebuild --flake /path/to/flake#nixos-wsl`

This repo is intended to quickly get you up to speed with NixOS.

If you follow this guide and discover easier/better ways for new users to get started, feel free to contact us directly or open a pull-request with suggestions.

## The repo structure

A quick overview of the repo folder structure:

------- nixos-wsl-quickstart
|
|--- docs (all further documentation)
|
|--- hosts (specific host configurations)
|  |
|  \--- <host>
|     |
|     \--- modules (all split modules instead of one big configuration.nix file)
|
|--- modules (all generic modules not specific to a host)
|  |
|  |--- common (all common modules)
|  |  |
|  |  \--- <any module category> (group modules by your preferred distinctions for better maintainability)
|  |
|  \--- common-desktop (all common modules, only for desktops or laptops, but not for server configurations)
|
\--- scripts (any scripts like bash of PowerShell needed in support of this flake)
