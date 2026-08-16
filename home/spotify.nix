{ pkgs, ... }:

{
  home.packages = [ pkgs.spotify ];

  # Run Spotify natively on Wayland so fractional scaling stays sharp.
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
