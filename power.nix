{ ... }:

{
  # Hyprland decides whether closing the lid should enter clamshell mode or
  # suspend, so logind must not handle the same switch independently.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # TLP applies separate AC/battery defaults for the CPU, GPU, PCIe, USB,
  # networking and other devices. Its profile daemon replaces PPD's D-Bus API.
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    pd.enable = true;
  };
}
