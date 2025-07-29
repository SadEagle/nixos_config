{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg.enableTridactylNative = true; # Required for Tridactyl native messaging
    };
    profiles.alice = {
      # extensions = {
      #   packages = with pkgs.nur.repos.rycee.firefox-addons; [
      #     tridactyl
      #     darkreader
      #     bitwarden
      #     sponsorblock
      #     youtube-nonstop
      #     return-youtube-dislikes
      #     simple-translate
      #   ];
      # };
      settings = {
        # Hide menu when pressing alt
        "ui.key.menuAccessKeyFocuses" = false;
        # Hide tabs fullscreen
        "browser.fullscreen.autohide" = false;
        # Hide translate suggestions
        "browser.translations.automaticallyPopup" = false;

        # Disable groups
        "browser.tabs.groups.enabled" = false;
        # Open last session
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_from_crash" = true;
        "browser.sessionstore.resume_session_once" = false;
      };
    };
    policies = {
      PasswordManagerEnabled = false;
      TranslateEnabled = false;
      PrintingEnabled = false;
    };
  };
}
