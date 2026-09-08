{ pkgs, ... }:
{
  # see https://wiki.nixos.org/wiki/Firefox
  programs.firefox = {
    enable = true;

    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
         "uBlock0@raymondhill.net" = {
            install_url       = moz "ublock-origin";
            installation_mode = "force_installed";
            updates_disabled  = true;
         };
      };
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = {
            uiTheme = "dark";
          };
        };
      };
    };


    profiles.default = {
      isDefault = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons;[
        bitwarden
	darkreader
	onepassword-password-manager #for work...
        (buildFirefoxXpiAddon {
          pname = "melange-theme";
          version = "1.0";
          addonId = "{dd525cca-875b-4072-97e6-a7758c3f8397}";
          url = "https://addons.mozilla.org/en-US/firefox/downloads/file/4168532/melange_theme-1.0.xpi";
          sha256 = "sha256-wh7/SkcPB1JeGkDUZd+DU+5fp3roKojC3teQXEN3S5w=";
          meta = with pkgs.lib; {
            homepage = "https://addons.mozilla.org/en-US/firefox/addon/melange-theme/";
            license = licenses.cc-by-nc-sa-30;
            platforms = platforms.all;
          };
	})
      ];
      settings = {
        "extensions.activeThemeID" = "{dd525cca-875b-4072-97e6-a7758c3f8397}";
	"extensions.autoDisableScopes" = 0; #so firefox doesnt auto-disable extensions lol
        "browser.startup.homepage" = "https://jaysa.net";
        "privacy.resistFingerprinting" = true;
	"browser.newtabpage.enabled" = false; #blank new tab page
	#"layout.css.prefers-color-scheme.content-override" = 0; #darken new tab page, unneeded w/ darkreader
      };
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        engines = {
          "Youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results?search_query=";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query";   value = "{searchTerms}"; }
                ];
              }
            ];
            icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "yt" ];
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query";   value = "{searchTerms}"; }
                ];
              }
            ];
            icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
      };
    };
  };
}
