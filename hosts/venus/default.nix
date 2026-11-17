{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/graphical.nix
    ../../modules/base.nix
  ];

  systemd.user.services.signal-cli-receive = {
    description = "signal-cli receive";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.signal-cli}/bin/signal-cli receive --ignore-attachments";
    };
  };

  systemd.user.timers.signal-cli-receive = {
    description = "Run signal-cli receive periodically";
    timerConfig = {
      OnCalendar = "*-*-* 0/6:00:00";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-746d9d4f-120a-4883-a8c6-4a1c8aaf24e1".device =
    "/dev/disk/by-uuid/746d9d4f-120a-4883-a8c6-4a1c8aaf24e1";

  #TODO move this into a graphical module... sort that out
  programs.steam.enable = true;

  networking.hostName = "venus";
}
