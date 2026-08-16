{ pkgs, ... }:

{
  # Runtime dependencies referenced by config/hyprland/hyprland.lua.
  home.packages = with pkgs; [
    brightnessctl
    hyprshutdown
    kdePackages.dolphin
    playerctl
    wireplumber # Provides wpctl.
  ];

  xdg.configFile."hypr/hyprland.lua".source =
    ../config/hyprland/hyprland.lua;
}
