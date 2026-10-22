{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  jovian = {
    devices.steamdeck.enable = true;
    steam = {
      enable = true;
      user = "jaysa";
      autoStart = true;
      desktopSession = "plasma";
    };
    decky-loader = {
      enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;

  networking.hostName = "nikki";
}
