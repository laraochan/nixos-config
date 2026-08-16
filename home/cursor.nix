{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };
}
