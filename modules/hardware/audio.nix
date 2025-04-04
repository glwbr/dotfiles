{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;
  cfg = config.aria.hardware.audio;
in
{
  options.aria.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether to enable audio support";
    extraPackages = mkOpt (listOf package) [ ] "Additional packages to include with audio settings";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.pulsemixer ] ++ cfg.extraPackages;

    aria.users.users.glwbr.extraGroups = [ "audio" ];

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;

      wireplumber = {
        enable = true;
      };
    };
  };
}
