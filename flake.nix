{
  description = "My own flake, my own Aria.";

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvim.url = "github:glwbr/nvim";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    yazi.url = "github:sxyazi/yazi";
  };

  outputs = { self, nixpkgs, disko, hm, ... }@inputs:
    let
      inherit (self) outputs;
      lib =
        nixpkgs.lib.extend (final: _: import ./lib { lib = final; } // hm.lib);

      systems = [ "aarch64-linux" "x86_64-linux" ];

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;

      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.alejandra);
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      # 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        sonata = lib.nixosSystem {
          modules = [ ./hosts/sonata ./modules disko.nixosModules.default ];
          specialArgs = { inherit inputs outputs; };
        };

        sinfonia = lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/sinfonia disko.nixosModules.default ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # 'home-manager --flake .#username@hostname'
      homeConfigurations = {
        "glwbr@sonata" = lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs outputs lib; };
          modules = [ ./home/glwbr/sonata.nix ];
          pkgs = pkgsFor.x86_64-linux;
        };

        "glwbr@sinfonia" = lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs outputs lib; };
          modules = [ ./home/glwbr/sinfonia.nix ];
          pkgs = pkgsFor.aarch64-linux;
        };
      };
    };
}
