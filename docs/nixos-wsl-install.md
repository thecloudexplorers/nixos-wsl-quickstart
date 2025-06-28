# Installing NixOS-WSL on Windows

If you would like to get started using NixOS while remaning on Windows, [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl) is one one of the options at your disposal.

There is a community based NixOS distro available specifically for WSL, aptly named [NixOS-WSL](https://nix-community.github.io/NixOS-WSL).

There are two main steps to install NixOS-WSL:

1. [Installing WSL itself](https://learn.microsoft.com/en-us/windows/wsl/install)
2. [Installing the NixOS-WSL distro](https://nix-community.github.io/NixOS-WSL/install.html)

## Scripted download & install of NixOS-WSL

In order to speed up the installation of NixOS-WSL [this script]() automates it for you. If is a faily simple script containing only the following steps (in case you want to run them manually):

1. `$packageUrl = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos.wsl"` | Note, I've parameterized this line in the script.
2. `$outPath = "$($env:USERPROFILE)\Downloads\$($packageFile)"` | Store the downloaded wsl file in the local users' Downloads folder.
3. `Invoke-WebRequest -Uri $packageUrl -OutFile "$outPath" -Method Get` | Actually download the file, and store it in the outpath.
4. `Invoke-Expression "wsl.exe --install --from-file $($outPath)"` | Start the wsl installation and use the nixos.wsl file as the distro (instead of the default WSL distros like Ubuntu).
5. From the commandline (in Windows) run the final validation: `wsl -l -v`
   1. And if it isn't version 2, run: `wsl --set-version <distro name> 2` | The distro name most likely being NixOS.

From this point on you will be able to run NixOS WSL from your Windows Terminal!

> If you would like to change the default username of the NixOS-WSL user, please read this first: [https://nix-community.github.io/NixOS-WSL/how-to/change-username.html](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html)

> NixOS-WSL works almost completely like NixOS for configuration purposes. The exception is the default username needing to be renamed according to the specific steps, and defined in the configuration as such `wsl.defaultUser = "<your user name>";`

## Using flakes

Okay, so what do you now actually 'do' in NixOS-WSL? Well, get familiar with [NixOS in general](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution), [Nix Language Basics](https://nix.dev/tutorials/nix-language), and [Nix Flakes](https://nixos.wiki/wiki/Flakes).

Interestingly, once you are proficient in the use of NixOS configurations, you can even perform the installation/configuration of NixOS-WSL itself using the Nix lanuage.

Flakes are a bit abstract if all of NixOS is new to you, but it is recommended to just take the plunge and start using them from the start. They are very popular in the community and will increase the likelyhood of being able to find examples you can reverse-engineer to learn by example.

Want to get started using Nix Flakes *in NixOS-WSL*? Here you go:

- [https://nix-community.github.io/NixOS-WSL/how-to/nix-flakes.html](https://nix-community.github.io/NixOS-WSL/how-to/nix-flakes.html)

## Additional steps for NixOS-WSL & running VSCode / Codium

Would you like to run VSCode (or Codium) natively from NixOS-WSL? Perhaps you'd like to get a native Linux editing experience, while still technically working on Windows. The following configuration will allow you to do so *without* getting warnings for it, and with an automatic shortcut directly in Windows.

- Remove the WSL warning message
  -  `echo -e >> ~/.bashrc "\nexport GDK_SCALE=2\nalias codium='DONT_PROMPT_WSL_INSTALL=1 codium'"`
  -  `source ~/.bashrc`
-  [Set Fractional Scaling Support (in Windows)](https://github.com/microsoft/wslg/issues/23)
   - Create the following file in Windows: %UserProfile%\.wslgconfig
   - Add the following content to that file:
    ``` config file
    [system-distro-env]
    WESTON_RDP_DEBUG_DESKTOP_SCALING_FACTOR=100
    ```

- After you now start VSCode / Codium, zoom out twice (Ctrl-) to fix your default zoom level.
- Finally, create a shortcut in windows and add the following to the target field:
  - `C:\Windows\System32\wsl.exe bash -c "export GDK_SCALE=2 && DONT_PROMPT_WSL_INSTALL=1 codium"`
