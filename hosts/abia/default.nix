{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO move into arini.nix? tailscale only ssh?
  services.openssh.enable = true;

  networking.hostName = "abia";
}
