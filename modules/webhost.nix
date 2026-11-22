{ pkgs, inputs, ... }:

{
  #chat.jaysa.net matrix federation
  services.caddy.virtualHosts."jaysa.net".extraConfig = ''
    respond /.well-known/matrix/server `{"m.server":"chat.jaysa.net:443"}`
    header /.well-known/matrix/client Access-Control-Allow-Origin *
    respond /.well-known/matrix/client `{"m.homeserver":{"base_url":"https://chat.jaysa.net"}}`
    root * ${inputs.jaysa-web.packages.${pkgs.system}.default}
    try_files {path} {path}.html
    file_server
  '';
  services.caddy.virtualHosts."blog.jaysa.net".extraConfig = ''
    root * ${inputs.jaysa-blog.packages.${pkgs.system}.default}
    file_server
  '';
}
