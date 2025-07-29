{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   hyprshot
  #   fastfetch
  #
  #   foot
  #   yazi
  #   fish
  #   firefox
  #   btop
  #   fuzzel
  #   neovim
  # ];
  wayland.windowManager.hyprland = {
    enable = true;
    # extraConfig = builtins.readFile ../hyprland/hyprland.conf;
    settings =
      let
        terminal = "foot";
        file_manager = "yazi";
        shell = "fish";
        browser = "firefox";
        monitor_manager = "btop";
        selector = "fuzzel --terminal=${terminal}";
        editor = "nvim";

        mainMod = "SUPER";
      in
      {
        monitor = "eDP-1,preffered,auto,0.833333";

        exec-once = [
          "hypridle & waybar & hyprpaper"
          ''[workspace 1] ${terminal} ${shell} --no-config -c "fastfetch; exec ${shell}"''
          "[workspace 2] ${browser}"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 2;

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        cursor = {
          inactive_timeout = 2;
        };

        decoration = {
          rounding = 10;
          blur.enabled = false;
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        # INPUT
        input = {
          kb_layout = "us, ru";
          kb_options = "grp:alt_shift_toggle";
          follow_mouse = 1;

          sensitivity = 0;
        };

        # KEYBINDINGS
        bind = [
          "${mainMod}, C, killactive"
          "${mainMod}, F12, exec, hyprlock"
          # Apps
          "${mainMod}, Q, exec, ${terminal}"
          "${mainMod}, E, exec, ${terminal} ${shell} -c ${file_manager}"
          "${mainMod}, B, exec, ${terminal} ${shell} -c ${monitor_manager}"
          "${mainMod}, N, exec, ${terminal} ${shell} -c ${editor}"
          "${mainMod}, F, exec, ${selector}"
          # Center all windows
          "${mainMod}, V, togglefloating"
          "${mainMod}, V, centerwindow"
          # Change split vertical/horizontal
          "${mainMod}, T, togglesplit"
          # Switch workspace
          "${mainMod}, 1, workspace, 1"
          "${mainMod}, 2, workspace, 2"
          "${mainMod}, 3, workspace, 3"
          "${mainMod}, 4, workspace, 4"
          "${mainMod}, 5, workspace, 5"
          "${mainMod}, 6, workspace, 6"
          "${mainMod}, 7, workspace, 7"
          "${mainMod}, 8, workspace, 8"
          "${mainMod}, 9, workspace, 9"
          "${mainMod}, 0, workspace, 10"
          # Move active window to workspace
          "${mainMod} SHIFT, 1, movetoworkspace, 1"
          "${mainMod} SHIFT, 2, movetoworkspace, 2"
          "${mainMod} SHIFT, 3, movetoworkspace, 3"
          "${mainMod} SHIFT, 4, movetoworkspace, 4"
          "${mainMod} SHIFT, 5, movetoworkspace, 5"
          "${mainMod} SHIFT, 6, movetoworkspace, 6"
          "${mainMod} SHIFT, 7, movetoworkspace, 7"
          "${mainMod} SHIFT, 8, movetoworkspace, 8"
          "${mainMod} SHIFT, 9, movetoworkspace, 9"
          "${mainMod} SHIFT, 0, movetoworkspace, 10"
          # Change window position
          "${mainMod} L_Shift, H, movewindow, l"
          "${mainMod} L_Shift, L, movewindow, r"
          "${mainMod} L_Shift, K, movewindow, u"
          "${mainMod} L_Shift, J, movewindow, d"
          # Swap window position
          "${mainMod} Ctrl, H, swapwindow, l"
          "${mainMod} Ctrl, L, swapwindow, r"
          "${mainMod} Ctrl, K, swapwindow, u"
          "${mainMod} Ctrl, J, swapwindow, d"
          # Move window focus
          "${mainMod}, H, movefocus, l"
          "${mainMod}, L, movefocus, r"
          "${mainMod}, K, movefocus, u"
          "${mainMod}, J, movefocus, d"
          # Full screen
          ", F11, fullscreen"
          # Screenshot
          ", PRINT, exec, hyprshot -m region --cliboard-only"
          ",SHIFT PRINT, exec, hyprshot -m region -o ~/Pictures/Screenshots"
          # Sound
          "${mainMod}, F10, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "${mainMod}, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          "${mainMod}, F9, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          # Resize tiles
          "${mainMod}, right, resizeactive, 25 0"
          "${mainMod}, left, resizeactive, -25 0"
          "${mainMod}, up, resizeactive, 0 -25"
          "${mainMod}, down, resizeactive, 0 25"
          # Move float windows
          "${mainMod} Ctrl, L, moveactive, 50 0"
          "${mainMod} Ctrl, H, moveactive, -50 0"
          "${mainMod} Ctrl, K, moveactive, 0 -50"
          "${mainMod} Ctrl, J, moveactive, 0 50"
        ];

        windowrule = [
          # Websites with video opacity blacklist
          "opacity 0.96 0.94 0.98, class:${terminal}|${browser}"
          "opacity 0.98 0.96 1, class:${browser} title:.*(Twitch|YouTube).*"
          # Viewers settings
          "float, size 1280 900, center, class:mpv|org.gnome.Shotwell"
          "float, size 1280 900, center, class:${browser}, title:Library"
          # Ignore maximize requests from apps
          "suppressevent maximize, class:.*"
          # Fix some dragging issues with XWayland
          # "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
  };
}
