#
#  Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./hyprland
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ default.nix
#       ├─ ./programs
#       │   └─ games.nix
#       └─ ./hardware
#           └─ default.nix
#

{ pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/programs/games.nix)] ++        # Gaming
    [(import ../../modules/desktop/hyprland/default.nix)] ++ # Window Manager
    (import ../../modules/desktop/virtualisation) ++      # Virtual Machines & VNC
    (import ../../modules/hardware);                      # Hardware devices

  boot = {                                      # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    #initrd.kernelModules = [ "amdgpu" ];       # Video drivers
    
    loader = {                                  # For legacy boot:
      systemd-boot = {
        enable = true;
        configurationLimit = 5;                 # Limit the amount of configurations
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;                              # Grub auto select time
    };
  };

  hardware = {
    sane = {                                    # Used for scanning with Xsane
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

  environment = {                               # Packages installed system wide
    systemPackages = with pkgs; [               # This is because some options need to be configured.
      discord
      #plex
      simple-scan
      x11vnc
      wacomtablet
    ];
  };

  services = {
    blueman.enable = true;                      # Bluetooth
    samba = {                                   # File Sharing over local network
      enable = true;                            # Don't forget to set a password:  $ smbpasswd -a <user>
      shares = {
        share = {
          "path" = "/home/${user}";
          "guest ok" = "yes";
          "read only" = "no";
        };
      };
      openFirewall = true;
    };
  };

  nixpkgs.overlays = [                          # This overlay will pull the latest version of Discord
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz"; 
          sha256 = "1kwqn1xr96kvrlbjd14m304g2finc5f5ljvnklg6fs5k4avrvmn4";
        };}
      );
    })
  ];
}
