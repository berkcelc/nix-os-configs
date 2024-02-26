alias confedit="sudo nano /etc/nixos/hal-9000/configuration.nix"
alias confsave='sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confupdate='sudo nix flake update /etc/nixos/hal-9000 && sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confgarbage="sudo nix-collect-garbage -d"
alias confgit='cd /etc/nixos && git fetch origin && git pull origin main && git add . && git commit -m "Automated commit message" && git push origin main'
