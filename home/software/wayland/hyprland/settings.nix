{config, ...}: let
  pointer = config.stylix.cursor;
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    exec-once = [
      # Set cursor for Hyprland itself
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
      "systemctl --user start clight"
      "hyprlock"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];

    general = {
      gaps_in = 4;
      gaps_out = 6;
      border_size = 2;

      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        "HDMI-A-1, 2560x1440@60, 1920x0, 1"
      ];

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 4;

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;
        new_optimizations = true;

        passes = 3;
        size = 8;
        xray = true;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
    };

    animations = {
      enabled = true;
      bezier = [
        "fluent_decel, 0, 0.2, 0.4, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutCubic, 0.33, 1, 0.68, 1"
        "easeinoutsine, 0.37, 0, 0.63, 1"
      ];

      animation = [
        "windowsIn, 1, 1.7, easeOutCubic, slide"
        "windowsOut, 1, 1.7, easeOutCubic, slide"
        "windowsMove, 1, 2.5, easeinoutsine, slide"
        "border, 1, 2, default"

        # Fading
        "fadeIn, 1, 3, easeOutCubic"
        "fadeOut, 1, 3, easeOutCubic"
        "fadeSwitch, 1, 5, easeOutCirc"
        "fadeShadow, 1, 5, easeOutCirc"
        "fadeDim, 1, 6, fluent_decel"
        "border, 1, 2.7, easeOutCirc"
        "workspaces, 1, 2, fluent_decel, slide"
        "specialWorkspace, 1, 3, fluent_decel, slidevert"
      ];
    };

    group = {
      groupbar = {
        font_family = "UbuntuMono Nerd Font";
        font_size = 12;
        gradients = false;
      };
    };

    input = {
      kb_layout = "us,us";
      kb_variant = ",intl";
      kb_options = "caps:swapescape,grp:alt_space_toggle";

      # Type really fast
      repeat_delay = 170;
      repeat_rate = 30;

      # Focus change on cursor move
      follow_mouse = true;
      accel_profile = "flat";
      touchpad = {
        scroll_factor = 0.1;
        disable_while_typing = true;
      };
    };

    dwindle = {
      # Keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
      no_gaps_when_only = false;
      smart_split = false;
      smart_resizing = false;
    };

    master = {
      new_status = "master";
    };

    render = {
      direct_scanout = true;
    };

    misc = {
      # Disable auto polling for config file changes
      disable_autoreload = true;

      force_default_wallpaper = 0;

      # Disable dragging animation
      animate_mouse_windowdragging = false;

      # Disable variable refresh rate
      vrr = false;

      enable_swallow = true;
      swallow_regex = "^(A|a)lacritty|footclient|foot$";

      disable_splash_rendering = true;
      disable_hyprland_logo = true;
    };

    # Touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;
  };
}
