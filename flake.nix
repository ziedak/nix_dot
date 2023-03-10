{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur = {
    #     url = "github:nix-community/NUR";                                   # NUR Packages
    #   };

      # nixgl = {                                                             # OpenGL
      #   url = "github:guibou/nixGL";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

    # nil = {
    #   url = "github:oxalica/nil";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.rust-overlay.follows = "rust-overlay";
    # };

  };

  # All outputs for the system (configs)
  outputs = { home-manager, nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux"; # current system
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      username = "zied";
      monitors = {
        mainMonitor = "Virtual-1";
        secondMonitor = "DP-1";
      };
      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mySystems = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            {
              networking.hostName = hostname;
            }
            # General configuration (users, networking, sound, etc)
            ./core
            # General Desktop configuration (awesome,qtile, etc)
            ./desktop
            # Hardware config (bootloader, kernel modules, filesystems, etc)
            # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {
                  inherit inputs nixpkgs username hostname monitors;
                  inherit self;

                };
                # Home manager config (configures programs like firefox, zsh, eww, etc)
                users.${username} = (./. + "/hosts/${hostname}/user.nix");
              };

            }
          ];
          specialArgs = { inherit inputs username; };
        };

    in {

      packages.${system} = {
        catppuccin-folders = pkgs.callPackage ./theme/catppuccin/catppuccin-folders.nix {};
        catppuccin-gtk = pkgs.callPackage ./theme/catppuccin/catppuccin-gtk.nix {};
        catppuccin-cursors = pkgs.callPackage ./theme/catppuccin/catppuccin-cursors.nix {};
        rofi-calc-wayland = pkgs.callPackage ./theme/catppuccin/rofi-calc-wayland.nix {};
        rofi-emoji-wayland = pkgs.callPackage ./theme/catppuccin/rofi-emoji-wayland.nix {};
      };

      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                                Architecture   Hostname
        zedvm = mySystems inputs.nixpkgs system "zedvm";

      };
    };
}
