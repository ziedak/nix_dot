{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./blocker.nix
    ./bootloader.nix 
    ./cron.nix
    ./environment.nix
    ./fonts.nix
    ./hardware.nix
    ./i18n.nix
    ./mime.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./users.nix
    ./virtualisation.nix
    ./xserver
 ];
}
