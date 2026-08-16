{ ... }:

{
  imports = [
    ./discord.nix
    ./git.nix
    ./hyprland.nix
    ./noctalia.nix
    ./vscode.nix
  ];

  home.username = "larao";
  home.homeDirectory = "/home/larao";
  home.stateVersion = "26.05";
}
