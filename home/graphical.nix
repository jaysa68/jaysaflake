{ lib, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  imports = [
    ./sway.nix
    ./waybar.nix
    ./firefox.nix
  ];

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  programs.chromium.enable = true; # for playwright
  programs.ncmpcpp = {
    enable = true;
  };
  programs.halloy = {
    package = pkgs.symlinkJoin {
      name = "aiko-halloy";
      paths = [ pkgs.halloy ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/halloy --set WGPU_BACKEND gl
      '';
    }; # something something old hardware gpu compatibility
    enable = true;
    settings = {
      preview = {
        image = {
          action = "preview";
        };
      };
      font = {
        family = theme.fonts.mono;
        size = 14;
      };
      theme = "gruvbox";
      servers = {
        liberachat = {
          nickname = "jaysa";
          server = "irc.libera.chat";
          channels = [
            "#nixos"
            "#halloy"
          ];
          sasl.plain = {
            username = "jaysa";
            password_file = "/home/jaysa/.secrets/liberachat";
          };
        };
        ocf = {
          nickname = "jaysa";
          server = "irc.ocf.berkeley.edu";
          channels = [
            "#rebuild"
            "#off-topic"
          ];
          sasl.plain = {
            username = "jaysa";
            password_file = "/home/jaysa/.secrets/ocf-irc";
          };
        };
      };
      buffer.channel.topic.enabled = true;
    };
  };

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

  xdg.configFile."nwg-drawer/drawer.css".text = ''
    window {
      background-color: rgba(0, 0, 0, 0.85);
      color: ${theme.colors.hash.fg};
    }
  '';

  home.packages = with pkgs; [
    nwg-drawer
    gimp
    libreoffice
    pavucontrol
    handy
    cheese
    grim
    sway-contrib.grimshot
    slurp
    wl-clipboard

    signal-desktop
    signal-cli

    zoom-us
    google-chrome # microsoft teams is a bitch on firefox, but needed for customers
  ];

  programs = {
    #fuzzel = {
    #  enable = true;
    #  settings = {
    #    main = {
    #      font = "${theme.fonts.mono}:size=12";
    #      terminal = "foot";
    #    };
    #    colors = {
    #      background = theme.colors.rgba.bg;
    #      text = theme.colors.rgba.fg;
    #      prompt = theme.colors.rgba.muted;
    #      match = theme.colors.rgba.accent;
    #      selection = theme.colors.rgba.black;
    #      selection-text = theme.colors.rgba.fg;
    #      selection-match = theme.colors.rgba.accent;
    #      border = theme.colors.rgba.muted;
    #    };
    #    border = {
    #      width = 1;
    #      radius = 0;
    #    };
    #  };
    #};
  };
}
