{ config, lib, pkgs, host, ... }:
in
{
  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager = {
      qtile = {
        enable = true;}
        
        
  };
  };
    home.file.".config/qtile/config.py".source = ./config.py;
}