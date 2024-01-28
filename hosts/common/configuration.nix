{pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="20a0", ATTR{idProduct}=="41e5", MODE="0666"
  '';

  services.interception-tools = {
    enable = true;
    plugins = with pkgs; [
      interception-tools-plugins.caps2esc
    ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };  

  fonts = {
    fonts = with pkgs; [ 
    source-code-pro 
    fira-code
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome
    ]; 
    
    fontDir.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Programs system wide
  programs.fish.enable = true;
  programs.dconf.enable = true; 
  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pciutils
    vim
    htop
    # shell_gpt
    jq
    xdotool
    wireguard-tools
    veracrypt
    fzf
    fishPlugins.fzf-fish
    usbutils
  ];

  virtualisation.docker.enable = true;

  hardware.ledger.enable = true;

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  networking.firewall.checkReversePath = false;

  services.gnome.gnome-keyring.enable = true;
  
  environment.variables = {
    EDITOR = "hx";
  };
}