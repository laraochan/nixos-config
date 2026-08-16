{ pkgs, ... }:

{
  # Runtime dependencies referenced by config/hyprland/hyprland.lua.
  home.packages = with pkgs; [
    kdePackages.dolphin
    wl-clipboard
  ];

  # Bind services such as xdg-desktop-portal to the Hyprland session.
  systemd.user.targets.hyprland-session.Unit = {
    Description = "Hyprland session";
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
    PropagatesStopTo = [ "graphical-session.target" ];
  };

  xdg.configFile."hypr/hyprland.lua".source =
    ../config/hyprland/hyprland.lua;
}
