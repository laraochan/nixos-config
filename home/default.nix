{ ... }:

{
  imports = [
    ./git.nix
    ./hyprland.nix
    ./vscode.nix
  ];

  home.username = "larao";
  home.homeDirectory = "/home/larao";
  home.stateVersion = "26.05";
}
