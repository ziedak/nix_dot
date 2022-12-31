{
  config,
  pkgs,
  username,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "docker"
      "systemd-journal"
      "audio"
      "plugdev"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
      "power"
      "nix"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = ["ssh-ed25519 "];
  };

   # Enable automatic login for the user.
  #  services.xserver.displayManager={
  #   autoLogin.enable = true;
  #   autoLogin.user = ${username};
  #   };

}
