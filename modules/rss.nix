{ config, ... }:

{
  age.secrets.miniflux-admin.file = ../secrets/miniflux-admin.age;

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.miniflux-admin.path;
    config.BASE_URL = "https://rss.jaysa.net";
  };


services.caddy.virtualHosts."rss.jaysa.net".extraConfig = ''
    reverse_proxy 127.0.0.1:8080
  '';
}
