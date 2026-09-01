#pablo.tols/blog/computers/system-wide-colorscheme
let
  palette = rec {
    # melange dark
    # https://github.com/savq/melange-nvim/blob/master/term/foot/melange_dark.ini
    fg = "ECE1D7";
    bg = "292522";

    black   = "34302C";
    red     = "BD8183";
    green   = "78997A";
    yellow  = "E49B5D";
    blue    = "7F91B2";
    magenta = "B380B0";
    cyan    = "7B9695";
    white   = "C1A78E";

    brightBlack   = "867462";
    brightRed   = "D47766";
    brightGreen     = "85B695";
    brightYellow  = "EBC06D";
    brightBlue   = "A3A9CE";
    brightMagenta    = "CF9BC2";
    brightCyan    = "89B3B6";
    brightWhite = "ECE1D7";
  
    accent = fg;
    muted = brightBlack;
    urgent = brightRed;
    #good = green;
  };
in
{
  colors = {
    raw = palette;
    hash = builtins.mapAttrs (_: v: "#${v}") palette; # used by foot
    rgba = builtins.mapAttrs (_: v: "${v}ff") palette; # used by foot
  };
  fonts = {
    mono = "BlexMono Nerd Font";
    size = 12;
  };
}
