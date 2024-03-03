{ config, pkgs, ... }:

{
  home.username = "ryans";
  home.homeDirectory = "/home/ryans";

  imports = [ ./dconf.nix ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      confedit="sudo nano /etc/nixos/terminator/configuration.nix";
      confsave="sudo nixos-rebuild switch --flake '/etc/nixos/terminator#terminator'";
      confupdate="sudo nix flake update /etc/nixos/terminator && sudo nixos-rebuild switch --flake '/etc/nixos/terminator#terminator'";
      confgarbage="sudo nix-collect-garbage -d";
      confgit="cd /etc/nixos && sudo git fetch origin && sudo git pull origin main && sudo git add . && sudo git commit -m 'Manual commit message' && sudo git push origin main";
    };
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "BingWallpaper@ineffable-gmail.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "Vitals@CoreCoding.com"
      ];
    };
   "org/gnome/shell/extensions/bingwallpaper" = {
      hide = true;
      notify = false;
    };
    "org/extensions/caffeine" = {
      enable-fullscreen = false;
      show-indicator = "always";
      show-notifications = false;
    };
    "org/gnome/shell/extensions/vitals" = {
      position-in-panel = 2;
    };
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/privacy" = {
      remove-old-trash-files = true;
      remove-old-temp-files = true;
      old-files-age = lib.hm.gvariant.mkUint32 30;
      remember-recent-files = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}

