{
  config,
  pkgs,
  ...
}:

{
    
    programs.dconf.enable = true;

  services.xserver = {
      enable = true;
      resolutions = [
        { x = 1920; y = 1080; }
        { x = 1600; y = 900; }
        { x = 3840; y = 2160; }
      ];
    };

    environment.systemPackages = with pkgs; [       # Packages installed
    xclip
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
    #alacritty
    #sxhkd
  ];
    
#      xdg.portal = {                                  # Required for flatpak with window managers
#     enable = true;
#     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#   };
}