{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
      # ./specialisations.nix
      ./software
      inputs.nix-index-db.hmModules.nix-index
  ];
  home = {
    username = "lonen";
    homeDirectory = "/home/lonen";
    stateVersion = "23.11";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
