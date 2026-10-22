{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/graphical.nix
    ../../modules/base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.jovianPackages.linuxPackages;

  jovian = {
    devices.steamdeck.enable = true;
    steam = {
      enable = true;
      user = "jaysa";
    };
    decky-loader = {
      enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;

  services.greetd.settings.initial_session = {
    user = "jaysa";
    command = "sway";
  };

environment.systemPackages = with pkgs; [
  sc-controller # map steam deck buttons
  wvkbd # on-screen keeb
];

  networking.hostName = "nikki";
}
