{ config, lib, inputs, ...}:

{
    imports = [../../modules/default.nix ];
     config.home = {
        stateVersion = "22.11";
        extraOutputsToInstall = ["doc" "devdoc"];
     };
   
    
  
}
