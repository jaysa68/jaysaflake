# tiffany is my ocf staff vm
{ lib, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/minecraft.nix
    ../../modules/wordpress.nix
    ../../modules/matrix.nix
    ../../modules/webhost.nix
    ../../modules/rss.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  # TODO move into arini.nix? tailscale only ssh?
  services.openssh.enable = true;
  users.users.jaysa.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDY6tiLriB8L3kTdhv0fHmQrB7RGaLAL3VWkbv04GnTh jaysa@venus"
  ];

  networking = {
    hostName = "tiffany";
    networkmanager.enable = lib.mkForce false;
    useDHCP = false;
    interfaces.ens18 = {
      ipv4.addresses = [
        {
          address = "169.229.226.224";
          prefixLength = 24;
        }
      ];
      ipv6.addresses = [
        {
          address = "2607:f140:8801::1:224";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = "169.229.226.1";
    defaultGateway6 = "2607:f140:8801::1";
    nameservers = [
      "169.229.226.22"
      "2607:f140:8801::1:22"
    ];
  };
}
