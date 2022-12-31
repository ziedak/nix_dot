{ inputs,
  pkgs,
  config,
  lib,
  self,
  ... }:

{
    imports = [
        ./lightdm
    ]; 
}