{ ... }:
{
  services.wordpress = {
    webserver = "caddy";
    sites."paula.jaysa.net" = {
      database.name = "wordpress_paula";
      settings.WP_DEFAULT_THEME = "twentytwentyfour";
    };
    sites."demona.jaysa.net" = {
      database.name = "wordpress_demona";
      settings.WP_DEFAULT_THEME = "twentytwentyfour";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ]; # caddy and wordpress dont open by default

}
