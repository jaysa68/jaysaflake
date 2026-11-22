{ pkgs, ... }:

{
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "jaysa.net";
      public_baseurl = "https://chat.jaysa.net";
      enable_registration = true;
      registration_requires_token = true;
    };
  };
  services.postgresql = {
    enable = true;
    # needed for intiial server creation
    initialScript = pkgs.writeText "synapse-init.sql" ''
      CREATE ROLE "matrix-synapse" LOGIN;
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
        TEMPLATE template0 LC_COLLATE = "C" LC_CTYPE = "C";
    '';
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureClauses.login = true;
      }
    ];
  };
  services.caddy.virtualHosts."chat.jaysa.net".extraConfig = ''
      handle /_matrix/* {
      reverse_proxy 127.0.0.1:8008
    }
    handle /_synapse/* {
      reverse_proxy 127.0.0.1:8008
    }
    redir /admin /admin/
    handle_path /admin/* {
      handle /config.json {
        header Content-Type application/json
        respond `{"restrictBaseUrl":"https://chat.jaysa.net"}`
      }
      root * ${pkgs.ketesa}
      file_server
    }
    handle {
    root * ${
      pkgs.element-web.override {
        conf.default_server_config."m.homeserver" = {
          base_url = "https://chat.jaysa.net";
          server_name = "jaysa.net";
        };
      }
    }
      file_server
    }
  '';
}
