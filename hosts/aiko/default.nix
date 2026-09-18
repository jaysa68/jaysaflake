{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/graphical.nix
    ../../modules/base.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "aiko";

}
