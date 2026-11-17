{ pkgs, lib, ... }:
let
  atm10a = pkgs.fetchzip {
    url = "https://mediafilez.forgecdn.net/files/9023/4/ATM10AERO-0.7.1-server.zip";
    hash = "sha256-ef2nPHvGRXiHkd4+19c/46HcvETaq7TUuhJxLymbeLo";
    stripRoot = false;
  };
in
{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.turlockmc = {
      enable = true;
      package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_250;
      jvmOpts = "-Xms8G -Xmx12G";
      symlinks = {
        mods = "${atm10a}/mods";
	datapacks = "${atm10a}/datapacks";
      };
      files = {
        config = "${atm10a}/config";
        defaultconfigs = "${atm10a}/defaultconfigs";
        kubejs = "${atm10a}/kubejs";
      };
      serverProperties = {
        motd = "our perennial minecraft server. see https://blog.jaysa.net/2026/11/16/turlockmc for more info!";
        white-list = true;
        enforce-whitelist = true;
        allow-flight = true;
      };
      whitelist = {
        venomshank68 = "dc9a1c69-98ae-4e3d-9135-f7cc1548b19a";
        AshIsCash = "ac78e886-de1e-4fe2-8027-fd33d97d2095";
        PuffHunt = "b0ef1040-b9cf-4aed-8121-3a1aa49c4e3c";
        Sour_Surge = "c58094c3-3087-4606-a143-250f80a5bd6d";
        Demonaliza = "eaa1e2a3-e6f2-4371-a840-993367aaa213";
      };
    };
  };
}
