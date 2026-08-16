{ lib, pkgs, ... }:

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

  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";

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
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontconfig.defaultFonts = {
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK JP"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK JP"
      ];
      monospace = [
        "Noto Sans Mono"
        "Noto Sans Mono CJK JP"
      ];
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users."larao" = {
    isNormalUser = true;
    description = "larao";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.hyprland.enable = true;
  programs.dconf.enable = true;

  # Nautilus uses GVfs for trash, network locations and removable media.
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.noctalia-greeter = {
    enable = true;
    settings = {
      appearance = {
        # Noctalia Greeter 1.2.1 only applies a custom wallpaper when the
        # "Synced" scheme has a complete palette. Keep this palette aligned
        # with Noctalia's built-in Rosé Pine colors. Revisit this workaround
        # when the greeter can combine a built-in scheme with a wallpaper.
        scheme = "Synced";
        theme_mode = "dark";
        palette = {
          primary = "#ebbcba";
          on_primary = "#191724";
          secondary = "#9ccfd8";
          on_secondary = "#191724";
          tertiary = "#31748f";
          on_tertiary = "#e0def4";
          error = "#eb6f92";
          on_error = "#191724";
          surface = "#191724";
          on_surface = "#e0def4";
          surface_variant = "#26233a";
          on_surface_variant = "#908caa";
          outline = "#403d52";
          shadow = "#191724";
          hover = "#524f67";
          on_hover = "#e0def4";
        };
        wallpaper = {
          path = "${./assets/wallpaper.png}";
          fill_mode = "crop";
        };
      };
      cursor = {
        theme = "BreezeX-RosePine-Linux";
        size = 24;
        path = "${pkgs.rose-pine-cursor}/share/icons";
      };
      keyboard.layout = "us";
      idle.timeout = 300;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  # Noctalia reads battery information through UPower.
  services.upower.enable = true;

  # Hyprland decides whether closing the lid should enter clamshell mode or
  # suspend, so logind must not handle the same switch independently.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # TLP applies separate AC/battery defaults for the CPU, GPU, PCIe, USB,
  # networking and other devices. Its profile daemon replaces PPD's D-Bus API.
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    pd.enable = true;
  };

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

  system.stateVersion = "26.05";

}
