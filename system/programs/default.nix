{
  imports = [
    ./docker.nix
    ./fonts.nix
    ./home-manager.nix
    ./hyprland.nix
    ./virt.nix
    ./xdg.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
  };
}
