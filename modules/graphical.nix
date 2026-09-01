{ pkgs, ... }: {

  services.displayManager.regreet.enable = true;
  programs.sway.enable = true; #need to enable in system file for regreet to pick it up
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
    noto-fonts-color-emoji
  ];

}
