{ config, lib, pkgs, host, ... }:

{
 # xsession
   services.xserver = {
    enable = true;
    numlock.enable = true;
    windowManager = {
      qtile = {
        enable = true;
       
        };
    };
  };
    home.configFile= {
      "qtile/config.py".source = ./config.py;
    };
}