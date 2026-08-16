{ pkgs, ... }:

let
  rosePineHyprland = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "hyprland";
    rev = "9d08f2561266783ac96d31d518c896d5059e1878";
    hash = "sha256-nA/re4gWvOtH0OPqxJzp7lm8YS/qLHUhhS/6Og22TlU=";
  };
in

{
  # Start Wayland session services only while Hyprland is running. This keeps
  # Hyprland-specific services such as Noctalia out of GNOME sessions.
  wayland.systemd.target = "hyprland-session.target";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = true;

    extraLuaFiles."user-config" = {
      content = pkgs.replaceVars ../config/hyprland/hyprland.lua {
        rosePineTheme = "${rosePineHyprland}/dist/rose-pine.lua";
      };
      autoLoad = true;
    };
  };

  # Runtime dependencies referenced by config/hyprland/hyprland.lua.
  home.packages = with pkgs; [
    kdePackages.dolphin
    wl-clipboard
  ];

}
