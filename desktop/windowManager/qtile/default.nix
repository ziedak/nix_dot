{ username, lib, pkgs, host, ... }:

{
  services = {
    xserver = {
    enable = true;
    #numlock.enable = true;
    windowManager = {
      qtile = {
        enable = true;
        };
    };
  };
  };

  home-manager .users.${username}.home.file = {
    ".config/qtile/config.py".source = ./config.py;
  };
}