 { config, lib,hostname,monitors, pkgs, ... }:
 let
  monitor = with monitors;
    if hostname == "desktop" then
      "${pkgs.xorg.xrandr}/bin/xrandr --output ${secondMonitor} --mode 1920x1080 --pos 0x0 --rotate normal --output ${mainMonitor} --primary --mode 1920x1080 --pos 1920x0 --rotate normal"
    else if hostname == "laptop" || hostname == "vm" then
      "${pkgs.xorg.xrandr}/bin/xrandr --mode 1920x1080 --pos 0x0 --rotate normal"
    else "${pkgs.xorg.xrandr}/bin/xrandr --output virtual-1 --mode 1920x1080 --pos 0x0 --rotate normal"
   ;
    
  in
{  
     displayManager = {                          # Display Manager
         sessionCommands = monitor;
        
        lightdm = {
          enable = true;                          # Wallpaper and GTK theme
         # background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters = {
            gtk = {
              theme = {
                name = "Dracula";
                package = pkgs.dracula-theme;
              };
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = 16;
              };
            };
          };
        };
        # defaultSession = "none+bspwm";            # none+bspwm -> no real display manager
      };

}