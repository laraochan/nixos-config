{ inputs, pkgs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  home.packages = [ pkgs.adw-gtk3 ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      widget.clock.format = "{:%b %d %H:%M}";

      shell.launch_apps_as_systemd_services = true;

      idle = {
        pre_action_fade_seconds = 2.0;
        behavior = {
          lock = {
            timeout = 600;
            action = "lock";
            enabled = true;
          };
          screen-off = {
            timeout = 900;
            action = "screen_off";
            enabled = true;
          };
        };
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Rosé Pine";

        # Generate GTK CSS from the active Noctalia palette. The templates
        # install it for both legacy GTK apps and GTK 4/libadwaita apps.
        templates = {
          enable_builtin_templates = true;
          builtin_ids = [
            "gtk3"
            "gtk4"
          ];
        };
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        directory = "${../assets}";
        default.path = "${../assets/wallpaper.png}";
      };
    };
  };

  systemd.user.services.noctalia.Service.Environment =
    [ "LC_TIME=en_US.UTF-8" ];
}
