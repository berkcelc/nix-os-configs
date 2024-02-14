{
    description = "My various system flakes";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        lanzaboote = {
        url = "github:nix-community/lanzaboote/v0.3.0";
        # Optional but recommended to limit the size of your system closure.
        inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, lanzaboote, ...}: {
        nixosConfigurations = {
            hal-9000 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                
                    # Lanzaboote (Secure Boot)
                    lanzaboote.nixosModules.lanzaboote
                    ({ pkgs, lib, ... }: {
                        boot.loader.systemd-boot.enable = lib.mkForce false;

                        boot.lanzaboote = {
                        enable = true;
                        pkiBundle = "/etc/secureboot";
                        };
                    })
                ];
            };
        };
    };
}