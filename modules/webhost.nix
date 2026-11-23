{ pkgs, inputs, ... }:

{
  # chat.jaysa.net matrix federation
  # openfreemap location sharing
  services.caddy.virtualHosts."jaysa.net".extraConfig = ''
            respond /.well-known/matrix/server `{"m.server":"chat.jaysa.net:443"}`
            header /.well-known/matrix/client Access-Control-Allow-Origin *
    	respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://chat.jaysa.net"},"m.tile_server":{"map_style_url":"https://tiles.openfreemap.org/styles/liberty"}}`
            root * ${inputs.jaysa-web.packages.${pkgs.system}.default}
            try_files {path} {path}.html
            handle_errors {
          rewrite * /404.html
          file_server
        }
            file_server
  '';
  services.caddy.virtualHosts."blog.jaysa.net".extraConfig = ''
        root * ${inputs.jaysa-blog.packages.${pkgs.system}.default}
        handle_errors {
      rewrite * /404.html
      file_server
    }
        file_server
  '';
}
