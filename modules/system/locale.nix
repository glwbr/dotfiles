{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.system.locale;
in
{
  options.aria.system.locale = {
    enable = mkBoolOpt false "Whether to manage locale settings";
  };

  config = lib.mkIf cfg.enable {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";

      extraLocaleSettings = {
        LC_TIME = lib.mkDefault "pt_BR.UTF-8";
        LC_CTYPE = lib.mkDefault "pt_BR.UTF-8";
      };

      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
        "pt_BR.UTF-8/UTF-8"
      ];
    };

    location.provider = "geoclue2";
    time.timeZone = lib.mkDefault "America/Bahia";
    time.hardwareClockInLocalTime = lib.mkDefault true;
  };
}
