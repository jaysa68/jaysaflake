{ config, ... }:
let
  theme = import ./theme.nix;
in
{
  wayland.windowManager.sway = {
  enable = true;
  config = {
    #input."type:keyboard".xkb_options = "altwin:swap_alt_win"; #thinkpad W540 keyboard quirk... but then i didnt need it? weird
    input."type:touchpad" = {
      tap = "enabled";
    };
    output."*".bg = "${./wallpapers/slime-rancher-2-chaos.png} fill";
    modifier = "Mod4";
    window = {
      titlebar = false;
    };
    gaps = {
      inner = 8;
      outer = 0;
    };
    bars = [ ]; #to disable swaybar cuz i use waybar
    colors = {
      focused = {
        border = theme.colors.hash.fg;
	background = theme.colors.hash.bg;
	text = theme.colors.hash.fg;
	indicator = theme.colors.hash.green;
        childBorder = theme.colors.hash.accent;
      };
      unfocused = {
        border = theme.colors.hash.muted;
        childBorder = theme.colors.hash.muted;
	background = theme.colors.hash.bg;
	text = theme.colors.hash.fg;
	indicator = theme.colors.hash.green;
      };
    };
    keybindings =
      let
        mod = config.wayland.windowManager.sway.config.modifier;
      in
      {
	  "${mod}+q" = "exec foot"; #i like opening terminals with 1 hand
	  "${mod}+c" = "kill"; #i like closing stuff with 1 hand
	  "${mod}+d" = "exec fuzzel";

	  "${mod}+h" = "focus left";
	  "${mod}+j" = "focus down";
	  "${mod}+k" = "focus up";
	  "${mod}+l" = "focus right";

	  "${mod}+Shift+h" = "move left";
	  "${mod}+Shift+j" = "move down";
	  "${mod}+Shift+k" = "move up";
	  "${mod}+Shift+l" = "move right";

          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+a" = "focus parent";

          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 0";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 0";

	  "${mod}+Shift+minus" = "move scratchpad";
	  "${mod}+minus" = "scratchpad show";

	  "${mod}+Shift+c" = "reload";
	  "${mod}+Shift+e" = "swaymsg exit";
	  "${mod}+r" = "mode resize";
      };
    };
  };
}
