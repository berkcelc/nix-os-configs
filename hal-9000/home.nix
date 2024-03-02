{ config, pkgs, ... }:

{
  home.username = "ryansamuels";
  home.homeDirectory = "/home/ryansamuels";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      confedit="sudo nano /etc/nixos/hal-9000/configuration.nix"
      confsave='sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
      confupdate='sudo nix flake update /etc/nixos/hal-9000 && sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
      confgarbage="sudo nix-collect-garbage -d"
      confgit='cd /etc/nixos && sudo git fetch origin && sudo git pull origin main && sudo git add . && sudo git commit -m "Manual commit message" && sudo git push origin main'
    };
  };
}
