{ ... }:
{
  programs.waybar = {
    enable = true;
    style = (builtins.readFile ../waybar/style.css);

    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        spacing = 0;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "battery"
          "network"
          "wireplumber"
          "hyprland/language"
          "clock#date"
          "clock#time"
        ];

        # Enhancement modules
        # Left modules
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
            "10" = "X";
          };
          "sort-by-number" = true;
        };

        # Right modules
        battery = {
          interval = 30;
          states = {
            warning = 40;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        network = {
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "🕸️ Internet";
          format-disconnected = "Disconnected";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname}";
        };
        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "MUTED";
          on-click = "pwvucontrol";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        # FIX: dont work language change
        "hyprland/language" = {
          format = "{}";
          format-en = "EN";
          format-ru = "RU";
          keyboard-name = "semico---usb-gaming-keyboard-";
          on-click = "hyprctl switchxkblayout semico---usb-gaming-keyboard- next";
        };
        "clock#time" = {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}";
          tooltip = false;
          #"tooltip-format" = "{:%e %B %Y}"
        };
      }
    ];
  };

}
