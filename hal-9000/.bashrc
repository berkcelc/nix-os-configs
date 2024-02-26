alias confedit="sudo nano /etc/nixos/hal-9000/configuration.nix"
alias confsave='sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confupdate='sudo nix flake update /etc/nixos/hal-9000 && sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confgarbage="sudo nix-collect-garbage -d"
alias confgit='cd /etc/nixos && sudo git fetch origin && sudo git pull origin main && sudo git add . && sudo git commit -m "Automated commit message" && sudo git push origin main'
