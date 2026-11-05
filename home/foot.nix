{ ... }:

let
  theme = import ./theme.nix;

in
{
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
}
