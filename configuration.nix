# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  rosePineFcitx5 = pkgs.stdenvNoCC.mkDerivation {
    pname = "rose-pine-fcitx5";
    version = "unstable-2022-12-11";

    src = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "fcitx5";
      rev = "01c291bc4fa5095c7a7c2ab177a9efc2042c5026";
      hash = "sha256-pNFDzsURMsNUJRz1jjyOb9uLjCtMbNuo3ARvv0rsvLg=";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fcitx5/themes
      cp -r rose-pine rose-pine-moon rose-pine-dawn $out/share/fcitx5/themes/
      runHook postInstall
    '';
  };
in

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "discord-unwrapped"
      "obsidian"
      "spotify"
      "vscode"
    ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./power.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Prefer Japanese glyph variants when applications request generic fonts.
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontconfig.defaultFonts = {
      sansSerif = [
        "DejaVu Sans"
        "Noto Sans CJK JP"
      ];
      serif = [
        "DejaVu Serif"
        "Noto Serif CJK JP"
      ];
      monospace = [
        "DejaVu Sans Mono"
        "Noto Sans Mono CJK JP"
      ];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."larao" = {
    isNormalUser = true;
    description = "larao";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Packages needed system-wide rather than only by the desktop user.
  environment.systemPackages = with pkgs; [
  ];

  programs.hyprland.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  # Noctalia reads battery information through UPower.
  services.upower.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        rosePineFcitx5
      ];

      ignoreUserConfig = true;
      settings.addons.classicui.globalSection.Theme = "rose-pine";
      settings.inputMethod = {
        GroupOrder."0" = "Default";
	"Groups/0" = {
	  Name = "Default";
	  "Default Layout" = "us";
	  DefaultIM = "mozc";
	};
	"Groups/0/Items/0".Name = "keyboard-us";
	"Groups/0/Items/1".Name = "mozc";
      };
    };
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
