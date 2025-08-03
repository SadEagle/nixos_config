{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking = {
    hostName = "atlantis";
    networkmanager.enable = true;
  };
  services.v2raya.enable = true;

  # GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # AMD GPU support
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  time.timeZone = "Asia/Almaty";

  # Internalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Cascadia Code NF";
    keyMap = "us";
  };

  # Users
  users.users.tiso = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    hashedPassword = "$y$j9T$73KY5Hojqw4fdXp.WyxgX0$GiyjjoMJ8evOhTJqFQ1W3VU3WD9QiPik7198wydTWs0";
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts-emoji
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wl-clipboard
    neovim

    fuzzel
    btop-rocm

    valkey
    sqlite

    arion
  ];

  # Docker
  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  # Programs
  programs.ssh.startAgent = true;
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # Services
  # Enable touchpad support
  services.libinput.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    ensureDatabases = [ "mainDB" ];
  };

  # TODO: redo forgejo, add secret to actions
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      server = {
        ROOT_URL = "https://localhost:3000";
      };
      acations = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer.ENABLED = false;
    };
  };
  # # Forgejo actions
  # services.gitea-actions-runner = {
  #   package = pkgs.forgejo-actions-runner;
  #   instances.default = {
  #     enable = true;
  #     name = "super-nix";
  #     url = "http://localhost:3000/";
  #     token = "6S7uMoel403CIwiJSIjaVh1K12wEMKhNKYh36LG1";
  #     labels = [
  #       "nix-mix:docker://nixos/nix:latest"
  #     ];
  #   };
  # };

  # Greetd.Agreety
  services.getty.helpLine = lib.mkForce "";
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
      };
    };
  };

  # # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      # V2raya default ports
      21070
      21071
      21072
    ];
  };
}
