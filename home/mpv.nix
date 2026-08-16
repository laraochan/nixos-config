{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      vo = "gpu-next";
      hwdec = "auto-safe";
    };

    # Expose playback controls and metadata to Noctalia.
    scripts = [ pkgs.mpvScripts.mpris ];
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "video/mp4" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
    };
    defaultApplications = {
      "video/mp4" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
    };
  };
}
