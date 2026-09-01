{ lib, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  imports = [ ./sway.nix ./waybar.nix ./neovim.nix ];

  home = {
    username = "jaysa";
    homeDirectory = "/home/jaysa";
    stateVersion = "26.05";
    # from rraval/nix
    activation.sshKeygen = lib.hm.dag.entryAfter [  "writeBoundary" ] ''
      if [[ ! -f "$HOME"/.ssh/id_ed25519 ]]; then
        run ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "$HOME"/.ssh/id_ed25519 -N ""
      fi
    '';
  };

  programs.halloy = {
    package = pkgs.symlinkJoin {
      name = "aiko-halloy";
      paths = [ pkgs.halloy ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/halloy --set WGPU_BACKEND gl
      '';
    };
    enable = true;
    settings = {
       font = {
         family = theme.fonts.mono;
         size = 14;
       };
       theme = "gruvbox";
       servers = {
         liberachat = {
           nickname = "jaysa";
           server = "irc.libera.chat";
           channels = [ "#nixos" ];
           sasl.plain = {
             username = "jaysa";
             password_file = "/home/jaysa/.secrets/liberachat";
           };
         };
	 ocf = {
	   nickname = "jaysa";
	   server = "irc.ocf.berkeley.edu";
	   channels = [ "#rebuild" "#off-topic" ];
	   sasl.plain = {
	     username = "jaysa";
	     password_file = "/home/jaysa/.secrets/ocf-irc";
	   };
	 };
       };
    buffer.channel.topic.enabled = true;
    };
  };
  #xdg.configFile."halloy/themes/melange.toml.text = ''
  #  [general]
  #  background = "#{themes.colors.raw.bg}"
  #'';

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${theme.fonts.mono}:size=12"; # make terminal font large enough to be readable
	pad = "6x6";
      };
      colors-dark = {
        background = theme.colors.raw.bg;
        foreground = theme.colors.raw.fg;

	regular0 = theme.colors.raw.black;
	regular1 = theme.colors.raw.red;
	regular2 = theme.colors.raw.green;
	regular3 = theme.colors.raw.yellow;
	regular4 = theme.colors.raw.blue;
	regular5 = theme.colors.raw.magenta;
	regular6 = theme.colors.raw.cyan;
	regular7 = theme.colors.raw.white;

	bright0 = theme.colors.raw.brightBlack;
	bright1 = theme.colors.raw.brightRed;
	bright2 = theme.colors.raw.brightGreen;
	bright3 = theme.colors.raw.brightYellow;
	bright4 = theme.colors.raw.brightBlue;
	bright5 = theme.colors.raw.brightMagenta;
	bright6 = theme.colors.raw.brightCyan;
	bright7 = theme.colors.raw.brightWhite;
      };
    };
  };

  home.packages = with pkgs; [
    firefox
    claude-code
    gimp

    zip
    xz
    unzip

    gh
    vim

    ripgrep
    jq

    which
    fastfetch
    htop
    btop
    
    pavucontrol
    grim
    sway-contrib.grimshot
    slurp
    wl-clipboard

  ];

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "jaysa68";
	user.email = "git@jaysa.net";
	init.defaultBranch = "master";
	pull.rebase = true;
      };
    };
    fuzzel = {
      enable = true;
      settings = {
        main = {
	  font = "${theme.fonts.mono}:size=12";
          terminal = "foot";
	};
	colors = {
	  background      = theme.colors.rgba.bg;
	  text            = theme.colors.rgba.fg;
	  prompt          = theme.colors.rgba.muted;
	  match           = theme.colors.rgba.accent; 
	  selection       = theme.colors.rgba.black; 
	  selection-text  = theme.colors.rgba.fg; 
	  selection-match = theme.colors.rgba.accent; 
	  border          = theme.colors.rgba.muted; 
	};
	border = {
	  width = 1;
	  radius = 0;
	};
      };
    };
    zsh = {
      enable = true;
      defaultKeymap = "emacs"; #cuz nvim is default editor, have to set this
      shellAliases = {
        rebuild = "git -C ~/jaysaflake add -A && sudo nixos-rebuild switch --flake ~/jaysaflake"; #Can later explore colmena and other build + deploy options... this works fine for now i think
      };
    };
  };
}
