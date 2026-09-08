{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/graphical.nix
      ../../modules/base.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-746d9d4f-120a-4883-a8c6-4a1c8aaf24e1".device = "/dev/disk/by-uuid/746d9d4f-120a-4883-a8c6-4a1c8aaf24e1";

  networking.hostName = "venus";
}
