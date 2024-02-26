alias confedit="sudo nano /etc/nixos/terminator/configuration.nix"
alias confsave='sudo nixos-rebuild switch --flake "/etc/nixos/terminator#terminator"'
alias confupdate='sudo nix flake update /etc/nixos/terminator && sudo nixos-rebuild switch --flake "/etc/nixos/terminator#terminator"'
alias confgarbage="sudo nix-collect-garbage -d"
alias confgit='cd /etc/nixos && git fetch origin && git pull origin main && git add . && git commit -m "Automated commit message" && git push origin main'
