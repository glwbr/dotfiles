{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # import folders first
    ./anyrun
    ./browsers
    ./media
    ./terminal
    ./utilities
    ./wayland

    ./gtk.nix
  ];

  home.packages = with pkgs; [
    # social
    vesktop
    tdesktop

    # personalizations
    nixos-icons
    inputs.matugen.packages.${pkgs.system}.default

    # misc
    catimg
    cliphist
    colord
    ffmpegthumbnailer
    imagemagick
    jq
    pciutils
    xcolor

    # ags
    mission-center
    dart-sass
    overskride
  ];
}
