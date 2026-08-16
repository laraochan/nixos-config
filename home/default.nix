{ ... }:

{
  imports = [
    ./discord.nix
    ./git.nix
    ./hyprland.nix
    ./vscode.nix
    ./waybar.nix
  ];

  home.username = "larao";
  home.homeDirectory = "/home/larao";
  home.stateVersion = "26.05";
}
