{ pkgs, ... }:

let
  rosePineKvantumSource = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "kvantum";
    rev = "816e3383d73f44c32423d6b43ce1dc66a528cefd";
    hash = "sha256-/URQh491kXdXkgRWn16Pv8k1SbshwjFWoDTgXAmddPY=";
  };

  rosePineKvantum = pkgs.stdenvNoCC.mkDerivation {
    pname = "rose-pine-kvantum";
    version = "unstable-2024-07-09";
    src = rosePineKvantumSource;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/share/Kvantum"
      tar -xzf dist/rose-pine-iris.tar.gz -C "$out/share/Kvantum"

      runHook postInstall
    '';
  };
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";

    kvantum = {
      enable = true;
      themes = [ rosePineKvantum ];
      settings.General.theme = "rose-pine-iris";
    };
  };
}
