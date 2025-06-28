# read: https://learn.microsoft.com/en-us/windows/wsl/install
# read: https://nix-community.github.io/NixOS-WSL/install.html
# read: https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
# read: https://nix-community.github.io/NixOS-WSL/how-to/nix-flakes.html

$forge = "github.com"
$organization = "nix-community"
$repo = "NixOS-WSL"
$packageVersion = "2411.6.0"
$packageFile = "nixos.wsl"
$packageUrl = "https://$($forge)/$($organization)/$($repo)/releases/download/$($packageVersion)/$($packageFile)"

$outPath = "$($env:USERPROFILE)\Downloads\$($packageFile)"

Invoke-WebRequest -Uri $packageUrl -OutFile "$outPath" -Method Get

Invoke-Expression "wsl.exe --install --from-file $($outPath)"

# Don't forget to: wsl -l -v
# And if it isn't version 2, run: wsl --set-version <distro name> 2
