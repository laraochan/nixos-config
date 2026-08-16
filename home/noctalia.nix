{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      accessibility.ui_scale = 1.5;

      bar.main.scale = 1.5;

      widget.clock.format = "{:%b %d %H:%M}";

      shell.launch_apps_as_systemd_services = true;

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Rosé Pine";
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
