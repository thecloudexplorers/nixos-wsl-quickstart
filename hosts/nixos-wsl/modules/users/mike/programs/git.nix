{
  osConfig,
  ...
}:
let
  # If you generate ssh keys for commit signing per host, per forge/organization
  # like I do you never have to configure Git manually again with HomeManager :)
  signingKeyPath = "~/.ssh/signing-github-bearmannl-${osConfig.networking.hostName}.pub";
in
{
  # Most NixOS options have their 'personal' variant here in Home Manager options
  programs = {
    git = {
      enable = true;
      # Yes! I never have to configure my username & email manually again on
      # fresh host configurations! Configured through declaration here
      userName = "Mike Bearman";
      # Yes, these are the exact username and email I use on all
      # of my GitHub repos. Fill in your own per home manager file
      # and these will get stored into the --global scope of that user
      userEmail = "29874229+bearmannl@users.noreply.github.com";
      # In case you use git commit signing (you should!)
      signing = {
        key = signingKeyPath;
      };
      # Add any additional Git config settings like you normally
      # would using `git config --global commit.gpgsign true` for instance
      extraConfig = {
        commit = {
          gpgsign = true;
        };
        tag = {
          gpgsign = true;
        };
        gpg = {
          format = "ssh";
          ssh = {
              # Ensure you have actually added your allowed signers public
              # keys to this file on the drive or git will error out in use
              allowedsignersfile = "~/.config/git/allowed_signers";
          };
        };
        init = {
          defaultbranch = "main";
        };
        pull = {
          ff = "only";
          rebase = true;
        };
        merge = {
          ff = false;
        };
      };
    };
  };

}