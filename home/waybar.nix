{ lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      position = "top";
      margin-top = 6;
      margin-left = 6;
      margin-right = 6;
      margin-bottom = 0;
      "group/workspaces-box" = {
        orientation = "horizontal";
        modules = [ "sway/workspaces" ];
      };
      "group/clock-box" = {
        orientation = "horizontal";
        modules = [ "clock" ];
      };
      modules-left = [ "group/workspaces-box" ];
      modules-center = [ "group/clock-box" ];
      modules-right = [
        "cpu"
        "memory"
        "pulseaudio"
        "pulseaudio#mic"
        "network"
        "battery"
        "tray"
      ];
      clock = {
        format = "{:%a, %b %d - %I:%M %p}";
        format-alt = "{:%a, %b %d - %I:%M:%S %p}";
        interval = 60;
        tooltip-format = "<tt>{calendar}</tt>";
      };
      cpu = {
        interval = 5;
        format = " {usage}%";
        states = {
          warning = 80;
          critical = 90;
        };
      };
      memory = {
        interval = 5;
        format = " {percentage}%";
        states = {
          warning = 80;
          critical = 90;
        };
      };
      network = {
        interval = 2;
        format-wifi = "󰖩 {signalStrength}";
        format-ethernet = "󰈀 {signalStrength}";
        format-disconnected = "󰖪 {signalStrength}";
        tooltip-format-wifi = "{essid} ({bandwidthTotalBytes}) {ipaddr}";
      };
      pulseaudio = {
        format = "  {format_source}";
        format-muted = "   0%";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "pavucontrol";
        scroll-step = 2;
        tooltip-format = "{desc}";
      };
      "pulseaudio#mic" = {
        format = "{format_source}";
        format-muted = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = "󰍭  0%";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        tooltip-format = "{source_desc}";
      };
      battery = {
        format = "󰁹 {capacity}%";
        format-charging = "󰢝 {capacity}%";
        format-plugged = "󰂅 {capacity}%";
        interval = 30;
        states = {
          warning = 25;
          critical = 10;
        };
      };
    };
    style =
      let
        theme = import ./theme.nix;
        palette = lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: value: "@define-color ${name} ${value};") theme.colors.hash
        );
      in
      ''
                ${palette}

                * {
                  font-family: ${theme.fonts.mono};
                  font-size: 14px;
                  font-weight: bold;
                }
        	.modules-right {
        	  padding-right: 6px;
        	}
        	window#waybar {
        	  background: ${theme.colors.hash.bg};
        	  border: 2px solid ${theme.colors.hash.brightBlack};
        	}
                #workspaces-box, #clock-box, #pulseaudio, #network, #cpu, #memory, #battery, #tray {
                  background: ${theme.colors.hash.black};
                  border: 1px solid ${theme.colors.hash.brightBlack};
                  margin: 6px 0 6px 6px;
        	  color: @fg;
                  padding: 0 5px;
                }
        	#workspaces button {
        	  color: ${theme.colors.hash.white};
                  padding: 0 5px;
                  margin: 0;
                  border-radius: 0;
                  background: transparent;
        	}
        	#workspaces button.focused {
        	  color: ${theme.colors.hash.fg};
        	}
      '';
  };
}
