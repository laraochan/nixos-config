{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      append = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
      size = 10000;
    };

    shellAliases = {
      c = "clear";
      cp = "cp -i";
      ll = "ls -alF --color=auto";
      ls = "ls --color=auto";
      mv = "mv -i";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      rm = "rm -i";
    };

    initContent = ''
      # Keep substring history search convenient without overriding fzf's
      # Ctrl-R history widget.
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border=rounded"
      "--info=inline"
      "--color=bg+:#26233a,bg:#191724,spinner:#f6c177,hl:#eb6f92"
      "--color=fg:#e0def4,header:#eb6f92,info:#c4a7e7,pointer:#f6c177"
      "--color=marker:#9ccfd8,fg+:#e0def4,prompt:#c4a7e7,hl+:#eb6f92"
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      palette = "rose-pine";

      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      character = {
        success_symbol = "[❯](foam)";
        error_symbol = "[❯](love)";
        vimcmd_symbol = "[❮](iris)";
      };
      directory = {
        style = "bold foam";
        truncation_length = 4;
        truncate_to_repo = false;
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "bold iris";
        symbol = " ";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold love";
      };
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        style = "bold foam";
        symbol = "❄️ ";
      };
      cmd_duration = {
        format = "took [$duration]($style) ";
        min_time = 2000;
        style = "gold";
      };

      palettes.rose-pine = {
        base = "#191724";
        surface = "#1f1d2e";
        overlay = "#26233a";
        muted = "#6e6a86";
        subtle = "#908caa";
        text = "#e0def4";
        love = "#eb6f92";
        gold = "#f6c177";
        rose = "#ebbcba";
        pine = "#31748f";
        foam = "#9ccfd8";
        iris = "#c4a7e7";
        highlightLow = "#21202e";
        highlightMed = "#403d52";
        highlightHigh = "#524f67";
      };
    };
  };
}
