_: {
  imports = [
    ./avahi.nix
    ./backlight.nix
    ./gnome-services.nix
    ./greetd.nix
    ./power.nix
    ./samba.nix
  ];

  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
