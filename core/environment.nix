{inputs,
  config,
  pkgs,
  ...
}: {

  environment = {
    # # set channels (backwards compatibility)
    # etc = {
    #   "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
    #   "nix/flake-channels/home-manager".source = inputs.home-manager;
    # };

    variables = {
     
      BROWSER = "firefox";
      DIRENV_LOG_FORMAT = "";
      EDITOR = "nvim";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
      NIXOS_CONFIG = "$HOME/.config/nixos/nix_dot/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/nix_dot";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      XDG_DATA_HOME = "$HOME/.local/share";
    };

  systemPackages = with pkgs; [
    git
    nano
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  defaultPackages = [];
  };
}
