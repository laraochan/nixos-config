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
    defaultApplications."video/quicktime" = [ "mpv.desktop" ];
  };
}
