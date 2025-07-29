{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings =
      let
        accent = text;
        red = "rgb(f38ba8)";
        yellow = "rgb(f9e2af)";
        blue = "rgb(89b4fa)";
        text = "rgb(cdd6f4)";
        surface = "rgb(313244)";
        base = "rgb(1e1e2e)";

        lock_paper = toString ../hypr/Astrounaut.png;
        lock_icon = toString ../hypr/Avatar.png;
      in
      {
        # General
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        # Background
        background = {
          monitor = "";
          path = "${lock_paper}";
          blur_passes = 0;
          color = base;
        };

        # User avater
        image = {
          monitor = "";
          path = "${lock_icon}";
          size = 180;
          border_color = accent;
          position = "0, 300";
          halign = "center";
          valign = "center";
        };

        # Welcoming
        label = [
          {
            monitor = "";
            text = "Welcome";
            color = text;
            font_size = 36;
            font_family = "$font";
            position = "-75, 90";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "$home,";
            color = blue;
            font_size = 36;
            font_family = "$font";
            position = "150, 90";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "my";
            color = text;
            font_size = 36;
            font_family = "$font";
            position = "40, 40";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "dear:)";
            color = red;
            font_size = 36;
            font_family = "$font";
            position = "160, 40";
            halign = "center";
            valign = "center";
          }
          # Time
          {
            monitor = "";
            text = "$TIME";
            color = "$text";
            font_size = 90;
            font_family = "$font";
            position = "-60, 0";
            halign = "right";
            valign = "top";
          }
          # Date
          {
            monitor = "";
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = text;
            font_size = 25;
            font_family = "$font";
            position = "-60, -140";
            halign = "right";
            valign = "top";
          }
        ];

        # Input field
        input-field = {
          monitor = "";
          size = "360, 60";
          outer_color = accent;
          inner_color = surface;
          font_color = text;
          fade_on_empty = false;
          position = "0, -70";
          halign = "center";
          valign = "center";

          placeholder_text = "";
          dots_center = true;
          dots_spacing = 0.2;
          dots_size = 0.24;
          check_color = accent;
          fail_color = red;
          fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
          capslock_color = yellow;
        };

      };
  };
}
