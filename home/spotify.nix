{ pkgs, ... }:

let
  spotify-wayland = pkgs.symlinkJoin {
    name = "spotify-wayland";
    paths = [ pkgs.spotify ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/spotify --set NIXOS_OZONE_WL 1
    '';
  };
in
{
  # Scope native Wayland support to Spotify instead of every Electron app.
  home.packages = [ spotify-wayland ];
}
