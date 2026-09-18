{ pkgs, ... }: {

  services.displayManager.regreet.enable = true;
  programs.sway.enable = true; # need to enable in system file for regreet to pick it up
  services.printing.enable = true;
  services.avahi = {
    # for my XP-4105
    enable = true;
    nssmdns4 = true;
  };

  # The portal service runs with a stripped-down PATH, so the default monitor
  # choosers (wofi/rofi/slurp from the user profile) are never found and every
  # screenshare request fails with "no output found". Point it at slurp by
  # absolute store path instead.
  xdg.portal.wlr.settings.screencast = {
    chooser_type = "simple";
    chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  };
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
    noto-fonts-color-emoji
  ];

}
