{ lib, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  imports = [
    ./neovim.nix
  ];

  home = {
    username = "jaysa";
    homeDirectory = "/home/jaysa";
    stateVersion = "26.05";
    # from rraval/nix
    activation.sshKeygen = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ ! -f "$HOME"/.ssh/id_ed25519 ]]; then
        run ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME"/.ssh/id_ed25519 -N ""
      fi
    '';
  };

  home.packages = with pkgs; [
    claude-code

    zip
    xz
    unzip

    gh
    vim
    htop
    btop

    ripgrep
    jq
    which

    fastfetch

    # for arini
    devenv
    direnv
    nodejs

  ];

  programs = {
    lazygit = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      settings = {
        user.name = "jaysa68";
        user.email = "git@jaysa.net";
        init.defaultBranch = "master";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    zsh = {
      enable = true;
      defaultKeymap = "emacs"; # cuz nvim is default editor, have to set this
      shellAliases = {
        rebuild = "git -C ~/jaysaflake add -A && nix fmt ~/jaysaflake && sudo nixos-rebuild switch --flake ~/jaysaflake"; # Can later explore colmena and other build + deploy options... this works fine for now i think
      };
    };
  };
}
