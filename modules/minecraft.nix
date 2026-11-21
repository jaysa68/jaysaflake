{ pkgs, lib, ... }:
let
  grieflogger = pkgs.fetchurl {
    url = "https://cdn.modrinth.com/data/8oGVUFuX/versions/IrRNGJIR/grieflogger-1.2.10-1.21.1-neoforge.jar";
    hash = "sha256-/SUrxUZruU440jhrr7mSa3mLwlCybho6qA+HjrzLxKU=";
  };
  atm10a = pkgs.fetchzip {
    url = "https://mediafilez.forgecdn.net/files/9366/712/ATM10AERO-0.8.0-server.zip";
    hash = "sha256-jtben9CphEGiQsT+QkJo8yLA1m7qrBqb3L51bnolRvM=";
    stripRoot = false;
  };
  # we remove CrashAssistant; it's clientside and crashes the server (something about nix read-only files)
  # and add grief logger
  atm10a-mods = pkgs.runCommand "atm10a-mods" { } ''
    mkdir -p $out/mods
    ln -s ${atm10a}/mods/* $out/mods
    rm $out/mods/CrashAssistant-*.jar
    ln -s ${grieflogger} $out/mods/grieflogger-1.2.10-1.21.1-neoforge.jar
  '';
in
{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.turlockmc = {
      enable = true;
      package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_250.override {
        jre_headless = pkgs.jdk21_headless;
      };
      jvmOpts = "-Xms8G -Xmx12G";
      symlinks = {
        mods = "${atm10a-mods}/mods";
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
        Erfinnder = "b130b0f9-2d76-4905-ab68-74a86b63d645";
	EpicRon = "70d4caad-fb6a-487a-a4f9-6bbbcfba22f7";
	Daltostar776 = "b5933502-ec8a-4c7d-bf9a-828c06087323";
	Captain_Os = "624d98a7-bb58-4a5f-b63a-3fd5f90d41b4";
      };
    };
  };
}
