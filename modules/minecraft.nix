{ ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    serverProperties = {
      motd = "All the Mods + Aeronautics with Turlock gamers and friends";
    };
  };
}
