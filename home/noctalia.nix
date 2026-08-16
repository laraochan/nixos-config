{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    settings = {
      shell.launch_apps_as_systemd_services = false;

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Rosé Pine";
      };
    };
  };
}
