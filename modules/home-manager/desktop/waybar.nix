# Template nix module
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Can import other modules to bundle them together
  ];

  # With the imported modules can then use below to set default
  # enabled modules
  # module1.enable = lib.mkDefault true;

  options = {
    waybar.enable =
      lib.mkEnableOption "enables waybar module";
    waybar.niri = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable niri modules in waybar";
    };
  };

  config = lib.mkIf config.waybar.enable {
    home.packages = with pkgs; [pavucontrol];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          height = 30;
          spacing = 4;
          modules-left =
            ["custom/launcher"]
            ++ (lib.optionals (config.waybar.niri) ["niri/workspaces"])
            ++ ["custom/media"];
          modules-center = lib.optionals config.waybar.niri ["niri/window"];
          modules-right = [
            "keyboard-state"
            "idle_inhibitor"
            "pulseaudio"
            "network"
            "power-profiles-daemon"
            "format-icons"
            "cpu"
            "memory"
            "temperature"
            "backlight"
            "battery"
            "clock"
            "tray"
          ];
          keyboard-state = {
            numlock = true;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };
          "custom/launcher" = {
            format = "";
            on-click = "fuzzel";
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          tray = {spacing = 10;};
          clock = {
            format = "{:%a %b %e %Y %I:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% 󱐋";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
          power-profiles-daemon = {
            format = "{icon}";
            tooltip-format = "Power profile= {profile}\nDriver= {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} 󰈁";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          pulseaudio = {
            format = "{volume}% {icon}  {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = "󰝟 {icon} {format_source}";
            format-muted = "󰝟 {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "󰝟";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };
        };
      };
      style = ''
               * {
                 /* `otf-font-awesome` is required to be installed for icons */
                 font-family: FiraCode Nerd Font;
                 font-size: 12px;
               }


               @define-color background-darker rgba(30, 31, 41, 230);
        @define-color background #282a36;
        @define-color selection #44475a;
        @define-color foreground #f8f8f2;
        @define-color comment #6272a4;
        @define-color cyan #8be9fd;
        @define-color green #50fa7b;
        @define-color orange #ffb86c;
        @define-color pink #ff79c6;
        @define-color purple #bd93f9;
        @define-color red #ff5555;
        @define-color yellow #f1fa8c;

               window#waybar {
                 background-color: @background-darker;
                 border-bottom: 3px solid rgba(100, 114, 125, 0.5);
                 color: #ffffff;
                 transition-property: background-color;
                 transition-duration: .5s;
               }

               window#waybar.hidden {
                 opacity: 0.2;
               }

               window#waybar.termite {
                 background-color: #3F3F3F;
               }

               window#waybar.chromium {
                 background-color: #000000;
                 border: none;
               }

               button {
                 /* Use box-shadow instead of border so the text isn't offset */
                 box-shadow: inset 0 -3px transparent;
                 /* Avoid rounded borders under each button name */
                 border: none;
                 border-radius: 0;
               }

               /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
               button:hover {
                 background: inherit;
                 box-shadow: inset 0 -3px #ffffff;
               }

               #workspaces button {
                 padding: 0 5px;
                 background-color: transparent;
                 color: #ffffff;
               }

               #workspaces button:hover {
                 background: rgba(0, 0, 0, 0.2);
               }

               #workspaces button.focused {
                 background-color: #64727D;
                 box-shadow: inset 0 -3px #ffffff;
               }

               #workspaces button.urgent {
                 background-color: #eb4d4b;
               }

               #mode {
                 background-color: #64727D;
                 box-shadow: inset 0 -3px #ffffff;
               }

               #clock,
               #battery,
               #cpu,
               #memory,
               #disk,
               #temperature,
               #backlight,
               #network,
               #pulseaudio,
               #wireplumber,
               #custom-media,
               #tray,
               #mode,
               #idle_inhibitor,
               #scratchpad,
               #power-profiles-daemon,
               #mpd {
                 padding: 0 10px;
                 color: @background;
               }

               #window,
               #workspaces {
                 margin: 0 4px;
               }

               /* If workspaces is the leftmost module, omit left margin */
               .modules-left>widget:first-child>#workspaces {
                 margin-left: 0;
               }

               /* If workspaces is the rightmost module, omit right margin */
               .modules-right>widget:last-child>#workspaces {
                 margin-right: 0;
               }

               #clock {
                 background-color: @purple;
               }

               #battery {
                 background-color: @pink;
                 color: #000000;
               }

               #battery.charging,
               #battery.plugged {
                 color: #000000;
                 background-color: @pink;
               }

               @keyframes blink {
                 to {
                   background-color: #ffffff;
                   color: #000000;
                 }
               }

               /* Using steps() instead of linear as a timing function to limit cpu usage */
               #battery.critical:not(.charging) {
                 background-color: @red;
                 color: #ffffff;
                 animation-name: blink;
                 animation-duration: 0.5s;
                 animation-timing-function: steps(12);
                 animation-iteration-count: infinite;
                 animation-direction: alternate;
               }

               #power-profiles-daemon {
                 padding-right: 15px;
               }

               #power-profiles-daemon.performance {
                 background-color: @red;
                 color: #ffffff;
               }

               #power-profiles-daemon.balanced {
                 background-color: @purple;
                 color: #ffffff;
               }

               #power-profiles-daemon.power-saver {
                 background-color: @green;
                 color: #000000;
               }

               label:focus {
                 background-color: #000000;
               }

               #cpu {
                 background-color: @green;
                 color: #000000;
               }

               #memory {
                 background-color: @red;
               }

               #disk {
                 background-color: #964B00;
               }

               #backlight {
                 background-color: #90b1b1;
               }

               #network {
                 background-color: @cyan;
               }

               #network.disconnected {
                 background-color: #f53c3c;
               }

               #pulseaudio {
                 background-color: @yellow;
                 color: #000000;
               }

               #pulseaudio.muted {
                 background-color: #90b1b1;
                 color: #2a5c45;
               }

               #wireplumber {
                 background-color: #fff0f5;
                 color: #000000;
               }

               #wireplumber.muted {
                 background-color: #f53c3c;
               }

               #custom-media {
                 background-color: #66cc99;
                 color: #2a5c45;
                 min-width: 100px;
               }

               #custom-media.custom-spotify {
                 background-color: #66cc99;
               }

               #custom-media.custom-vlc {
                 background-color: #ffa000;
               }

               #temperature {
                 background-color: #f0932b;
               }

               #temperature.critical {
                 background-color: #eb4d4b;
               }

               #tray {
                 background-color: @background;
               }

               #tray>.passive {
                 -gtk-icon-effect: dim;
               }

               #tray>.needs-attention {
                 -gtk-icon-effect: highlight;
                 background-color: #eb4d4b;
               }

               #idle_inhibitor {
                 background-color: @background;
               }

               #idle_inhibitor.deactivated {
                 background-color: @background;
                 color: #ffffff;
               }

               #idle_inhibitor.activated {
                 background-color: @foreground;
                 color: #000000;
               }

               #mpd {
                 background-color: #66cc99;
                 color: #2a5c45;
               }

               #mpd.disconnected {
                 background-color: #f53c3c;
               }

               #mpd.stopped {
                 background-color: #90b1b1;
               }

               #mpd.paused {
                 background-color: #51a37a;
               }

               #language {
                 background: #00b093;
                 color: #740864;
                 padding: 0 5px;
                 margin: 0 5px;
                 min-width: 16px;
               }

               #keyboard-state {
                 background: #97e1ad;
                 color: #000000;
                 padding: 0 0px;
                 margin: 0 5px;
                 min-width: 16px;
               }

               #keyboard-state>label {
                 padding: 0 5px;
               }

               #keyboard-state>label.locked {
                 background: rgba(0, 0, 0, 0.2);
               }

               #scratchpad {
                 background: rgba(0, 0, 0, 0.2);
               }

               #scratchpad.empty {
                 background-color: transparent;
               }

               #privacy {
                 padding: 0;
               }

               #privacy-item {
                 padding: 0 5px;
                 color: white;
               }

               #privacy-item.screenshare {
                 background-color: #cf5700;
               }

               #privacy-item.audio-in {
                 background-color: #1ca000;
               }

               #privacy-item.audio-out {
                 background-color: #0069d4;
               }
      '';
    };
  };
}
