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

  xdg.configFile."hypr/hyprland.lua".source = pkgs.replaceVars ../config/hyprland/hyprland.lua {
    rosePineTheme = "${rosePineHyprland}/dist/rose-pine.lua";
  };
}
