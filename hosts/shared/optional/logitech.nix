{ pkgs, ... }:
{
  hardware = {
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true; # Solaar.
  };

  environment.systemPackages = with pkgs; [ solaar ];
  services.udev.packages = with pkgs; [
    logitech-udev-rules
    solaar
  ];
}
