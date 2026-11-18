{ ... }:
{
  services.wordpress = {
    webserver = "caddy";
    sites."paula.jaysa.net" = {
      settings.WP_DEFAULT_THEME = "twentytwentyfour";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ]; # caddy and wordpress dont open by default

}
