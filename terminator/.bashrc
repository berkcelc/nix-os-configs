alias confedit="sudo nano /etc/nixos/terminator/configuration.nix"
alias confsave='sudo nixos-rebuild switch --flake "/etc/nixos/terminator#terminator"'
alias confupdate='sudo nix flake update /etc/nixos/terminator && sudo nixos-rebuild switch --flake "/etc/nixos/terminator#terminator"'
alias confgarbage="sudo nix-collect-garbage -d"
alias confgit='cd /etc/nixos && sudo git fetch origin && sudo git pull origin main && sudo git add . && sudo git commit -m "Automated commit message" && sudo git push origin main'
