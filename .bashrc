alias confedit="sudo nano /etc/nixos/configuration.nix"
alias confsave='sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confupdate='sudo nix flake update /etc/nixos && sudo nixos-rebuild switch --flake "/etc/nixos/hal-9000#hal-9000"'
alias confgarbage="sudo nix-collect-garbage -d"
