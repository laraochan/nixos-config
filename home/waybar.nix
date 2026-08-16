{ ... }:

{
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      targets = [ "hyprland-session.target" ];
    };

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 8;

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "network"
        "pulseaudio"
        "backlight"
        "battery"
      ];

      "hyprland/workspaces" = {
        format = "{name}";
        sort-by-number = true;
        on-click = "activate";
      };

      "hyprland/window" = {
        format = "{title}";
        max-length = 60;
        separate-outputs = true;
      };

      clock = {
        format = "{:%a %m/%d  %H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      tray = {
        icon-size = 18;
        spacing = 8;
      };

      network = {
        format-wifi = "NET {essid} {signalStrength}%";
        format-ethernet = "LAN";
        format-disconnected = "NET down";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      };

      pulseaudio = {
        format = "VOL {volume}%";
        format-muted = "VOL muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };

      backlight = {
        format = "BRT {percent}%";
        on-scroll-up = "brightnessctl set +5%";
        on-scroll-down = "brightnessctl set 5%-";
      };

      battery = {
        interval = 30;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "BAT {capacity}%";
        format-charging = "BAT +{capacity}%";
        format-plugged = "BAT AC";
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(20, 24, 32, 0.92);
        color: #d8dee9;
      }

      #workspaces button {
        padding: 0 10px;
        color: #7f8c9d;
        background: transparent;
      }

      #workspaces button.active {
        color: #8fbcbb;
        box-shadow: inset 0 -2px #8fbcbb;
      }

      #workspaces button.urgent {
        color: #bf616a;
      }

      #window,
      #clock,
      #tray,
      #network,
      #pulseaudio,
      #backlight,
      #battery {
        padding: 0 10px;
      }

      #battery.warning {
        color: #ebcb8b;
      }

      #battery.critical {
        color: #bf616a;
      }
    '';
  };
}
