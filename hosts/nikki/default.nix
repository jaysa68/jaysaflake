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

  # TODO move these into a steam-deck.nix module
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

# sc-controller daemon for just nikki. dont want it on all machines
systemd.user.services.scc-daemon = {
  description = "SC Controller daemon";
  wantedBy = [ "graphical-session.target" ];
  partOf = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.sc-controller}/bin/scc-daemon start --foreground";
    Restart = "on-failure";
  };
};

  networking.hostName = "nikki";
}
