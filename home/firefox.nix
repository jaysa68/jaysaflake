{ pkgs, ... }:
{
  # see https://wiki.nixos.org/wiki/Firefox
  programs.firefox = {
    enable = true;

    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;
#      Bookmarks = [
#        { Title = "github"; URL = "https://github.com"; Placement = "toolbar"; Folder = "common"; }
#      ];
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
      containersForce = true;
      containers = {
        "1-personal" = { id = 1; color = "purple"; icon = "fingerprint"; };
	"2-arini" = { id = 2; color = "orange"; icon = "briefcase"; };
      };
      bookmarks = {
        force = true;
	settings = [
	  {
	    name = "Slack";
	    keyword = "sl";
	    url = "https://app.slack.com/client";
	  }
	  {
	    name = "Discord";
	    keyword = "d";
	    url = "https://discord.com/channels/";
	  }
	  {
	    name = "google calendar";
	    keyword = "cal";
	    url = "https://calendar.google.com";
	  }
	  {
	    name = "arini3 repo";
	    keyword = "arini3";
	    url = "https://github.com/arini-ai/arini3";
	  }
	  {
	    name = "arini3 PRs";
	    keyword = "prs";
	    url = "https://github.com/arini-ai/arini3/pulls";
	  }
	  {
	    name = "my own arini3 PRs";
	    keyword = "myprs";
	    url = "https://github.com/arini-ai/arini3/pulls/@me";
	  }
	];
      };
      search = {
        force = true;
        default = "google";
        privateDefault = "ddg";
        engines = {
          "Wiktionary" = {
            urls = [
              {
                template = "https://en.wiktionary.org/w/index.php?search={searchTerms}&title=Special:Search&go=Go";
                params = [
                  { name = "query";   value = "{searchTerms}"; }
                ];
              }
            ];
            definedAliases = [ "def" ];
          };
          "Youtube" = {
            urls = [
              {
                template = "https://www.youtube.com/results?search_query={searchTerms}";
                params = [
                  { name = "query";   value = "{searchTerms}"; }
                ];
              }
            ];
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
              definedAliases = [ "np" ];
	    };
          };
        };
      extensions = {
        settings."@testpilot-containers" = {
	  force = true;
	  settings = {
	    "siteContainerMap@@_discord.com" = {
	      userContextId = "1";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_app.slack.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_github.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_calendar.google.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_drive.google.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_app.infisical.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	    "siteContainerMap@@_spaceship.com" = {
	      userContextId = "2";
	      neverAsk = true;
	    };
	  };
	};
        packages = with pkgs.nur.repos.rycee.firefox-addons;[
          bitwarden
  	  darkreader
  	  onepassword-password-manager #for work...
  	  multi-account-containers
  	  easy-container-shortcuts # ctrl + shift + 1...9 for my container shortcuts. and others lol
  	  gruvbox-dark-theme
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
      };
      settings = {
        #"extensions.activeThemeID" = "{dd525cca-875b-4072-97e6-a7758c3f8397}"; #melange color scheme (needs tweaking)
	"extensions.activeThemeID" = "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}"; #gruvbox dark
	"extensions.autoDisableScopes" = 0; #prevent firefox from auto-disable extensions when first opening
        "browser.startup.homepage" = "https://jaysa.net";
        "privacy.resistFingerprinting" = false;
	"browser.newtabpage.enabled" = false; #blank nettw tab page
	#"layout.css.prefers-color-scheme.content-override" = 0;
	#"ui.systemUsesDarkTheme" = 1; #i can prob set some GTK var to get the same thing but like whatever. firefox own ui pages must be dark
        "browser.uiCustomization.state" = builtins.toJSON {
           placements = {
             widget-overflow-fixed-list = [ ];
             unified-extensions-area = [
               "_testpilot-containers-browser-action"              # Multi-Account Containers
               "addon_darkreader_org-browser-action"                # Dark Reader
               "firefox_container-shortcuts_strategery_io-browser-action"
             ];
             nav-bar = [
               "back-button"
               "forward-button"
               "stop-reload-button"
               "home-button"
               "customizableui-special-spring1"
               "vertical-spacer"
               "urlbar-container"
               "customizableui-special-spring2"
               "reset-pbm-toolbar-button"
               "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"  # 1Password
               "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"  # Bitwarden
               "ublock0_raymondhill_net-browser-action"
               "unified-extensions-button"
               "downloads-button"
             ];
             toolbar-menubar = [ "menubar-items" ];
             TabsToolbar = [
               "tabbrowser-tabs"
               "new-tab-button"
               "alltabs-button"
               "ai-window-toggle"
             ];
             vertical-tabs = [ ];
             PersonalToolbar = [
             "personal-bookmarks"
             ];
           };
           seen = [
             "reset-pbm-toolbar-button"
             "addon_darkreader_org-browser-action"
             "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
             "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
             "ai-window-toggle"
             "developer-button"
             "ublock0_raymondhill_net-browser-action"
             "screenshot-button"
             "firefox_container-shortcuts_strategery_io-browser-action"
             "_testpilot-containers-browser-action"
             ];
           dirtyAreaCache = [
             "unified-extensions-area"
             "nav-bar"
             "vertical-tabs"
             "PersonalToolbar"
             "toolbar-menubar"
             "TabsToolbar"
           ];
         currentVersion = 25;
         newElementCount = 6;
        };
      };
    };
  };
}
