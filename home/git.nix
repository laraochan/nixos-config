{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      user = {
        name = "larao";
        email = "me@larao.dev";
      };
    };
  };
}
