{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   hypridle
  #   hyprlock
  #   hyprsunset
  # ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      # WARN: add sleep for proper loading screens

      # Lock session
      listener = [
        # Brightness
        {
          timeout = 300;
          on-timeout = "hyprsunset -g 30%";
          on-resume = "pkill hyprsunset";
        }
        # Hyprlock
        {
          timeout = 480;
          on-timeout = "loginctl lock-session";
        }
        # Turn off monitors
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        # # Suspend session
        # {
        #   timeout = 1800;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };
}
