{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Keep extensions reproducible. Add or remove extensions here instead of
    # installing them from VS Code's Extensions view.
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        astro-build.astro-vscode
        jnoortheen.nix-ide
        mvllow.rose-pine
        rust-lang.rust-analyzer
      ];

      userSettings = {
        "git.autofetch" = true;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Rosé Pine";
      };
    };
  };
}
