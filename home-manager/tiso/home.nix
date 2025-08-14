{ pkgs, lib, ... }:
{

  home.username = "tiso";
  home.homeDirectory = "/home/tiso";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Nordzy icon";
  #     package = pkgs.nordzy-icon-theme;
  #   };
  #   cursorTheme = {
  #     name = "Nordzy-cursors";
  #     package = pkgs.nordzy-cursor-theme;
  #   };
  # };

  # # Firefox plugins needs
  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
  #     inherit pkgs;
  #   };
  # };

  # config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "steam"
  #   ];

  home.packages = with pkgs; [
    # Libs
    p7zip
    fzf
    fd
    ripgrep
    zoxide
    # Languages
    lua
    python314
    nodejs
    typescript

    # Hyprland extentions
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    # Extra apps
    yazi
    fastfetch
    # Non-system apps
    telegram-desktop
    transmission_4
    lutris-free
    gimp3
    krita
    pwvucontrol
  ];

  # Import programs
  imports = [
    ./programs
  ];

  programs.git = {
    enable = true;
    userName = "Sandy Solomon";
    userEmail = "sadsandeagle@gmail.com";

    lfs.enable = true;
    delta.enable = true;
    extraConfig = {
      # FIX: module below dont make proper delta commit, need to fix
      options = {
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          side-by-side = true;
          navigate = true;
          dark = true;
        };
        merge.conflictstyle = "zdiff3";
      };
      init = {
        defaultBranch = "master";
      };
    };
    ignores = [
      "__pycache__"
      ".venv"
      "*.db"
    ];
  };
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = 3;
        showBottomLine = false;
        mouseEvents = false;
        language = "en";
        expandFocusedSidePanel = true;
      };
      git.paging = {
        colorArg = "always";
        # pager = "delta --dark --paging=never --syntax-theme base16-256 --diff-so-fancy";
        pager = "${lib.getExe pkgs.delta} --dark --syntax-theme=Dracula --paging=never";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # LSPs
      nixd
      nixfmt-rfc-style
      # TODO: procede how to use `ty` and here
      rocmPackages.clang
      pyright
      ruff
      lua-language-server
      bash-language-server
      vscode-langservers-extracted
      typescript-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      # Instruments
      fd
      fzf
      lazygit
      ripgrep
    ];
  };
}
