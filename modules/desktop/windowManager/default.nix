{ inputs,
  pkgs,
  config,
  lib,
  self,
  ... }:

{
    imports = [
        ./qtile
        # ./bspwm
    ]; 
}