{ ... }:

{
  imports = [
    ./codex.nix
    ./cursor.nix
    ./discord.nix
    ./firefox.nix
    ./gh.nix
    ./git.nix
    ./ghostty.nix
    ./hyprland.nix
    ./mpv.nix
    ./neovim.nix
    ./noctalia.nix
    ./obsidian.nix
    ./shell.nix
    ./spotify.nix
    ./vscode.nix
  ];

  home.username = "larao";
  home.homeDirectory = "/home/larao";
  home.stateVersion = "26.05";
}
