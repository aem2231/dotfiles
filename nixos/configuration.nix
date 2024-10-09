{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable firewall
  networking.firewall.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true; 

  # Configure localization
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/London";
  services.xserver.xkb.layout = "us";

  #Enable X11
  #services.xserver.enable = true;
  
  #Bash aliases
  programs.bash.shellAliases = {
    eepymode = "systemctl suspend";
    powernap = "reboot";
  };
	
  # Enable display manager
  services.greetd = {
    enable = true;
    settings = {
     default_session.command = ''
      ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd Hyprland
    '';
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland
  '';

  #Enable gpu dxrivers
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable the hyprland compositor
  programs.hyprland.enable = true;

  # XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable sound with pipewire.
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # If you want to use JACK applications
  };

  # Enable the OpenSSH server.
  services.openssh.enable = true;

  # Define user accounts
  users.users.eris = {
    isNormalUser = true;
    description = "Eris";
    extraGroups = ["networkmanager" "wheel"]; 
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts 
  ];
  
  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"]; 
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  #Steam, also enables OpenGL by defualt 
  programs.steam = {
    enable = true;
    #package = ;
    gamescopeSession.enable = true;
  };
  
  #Enable gamemode daemon
  programs.gamemode.enable = true;

  # Automatic Garbage Collection
  nix.gc = {
             automatic = true;
             dates = "weekly";
             options = "--delete-older-than 7d";
           };

  #Enable direnv
  programs.direnv.enable = true;

  #ENable xpadneo
  hardware.xpadneo.enable = true;
  
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Desktop Applications
    firefox
    thunderbird
    alacritty
    kitty
    vesktop
    rofi-wayland
    spicetify-cli
    swww # wallpaper daemon
    networkmanagerapplet
    
    # Notifications
    dunst
    libnotify

    # Waybar
    (waybar.overrideAttrs (oldAttrs: {
       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
     })
    )

    #Development and IDE's
    vscode
    android-studio
    jetbrains.clion
    jetbrains.rider
    jetbrains.idea-community
    gcc
    cmake
    gdb
    qt5.full        

    #Gaming
    lutris
    protonup-qt
    lunar-client
    superTuxKart

    # Utilities
    vlc
    git
    vim
    wget
    curl
    unzip
    htop
    lf
    sxhkd
    grimblast
    obs-studio    
    wcalc
    playerctl
    pamixer    
    hyprshot
    grim
    jq
    slurp
    ethtool
    onlyoffice-bin
    feh   
    # *fetch
    neofetch
    pfetch
    owofetch
    yafetch
    afetch
    bunnyfetch
    fastfetch

    # Silly things
    cmatrix
    sl
    cowsay

  ];

  # Enable flatpak support
  services.flatpak.enable = true;

  # Enable thunar file manager
  programs.thunar.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.

  system.stateVersion = "23.11"; # Did you read the comment?
}
