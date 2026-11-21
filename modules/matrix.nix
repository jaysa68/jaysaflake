{ pkgs, ... }:

{
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "jaysa.net";
      public_baseurl = "https://chat.jaysa.net";
    };
  };
}
