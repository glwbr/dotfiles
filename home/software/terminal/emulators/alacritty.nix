{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };

      scrolling.history = 10000;

      font = {
        normal.family = "LigaSFMono Nerd Font";
        bold.family = "LigaSFMono Nerd Font Bold";
        italic.family = "LigaSFMono Nerd Font Italic";
        size = 16;
      };

      colors.draw_bold_text_with_bright_colors = true;
      window.opacity = 0.9;

      imports = [
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/alacritty/3c808cbb4f9c87be43ba5241bc57373c793d2f17/catppuccin-mocha.yml";
          hash = "sha256-28Tvtf8A/rx40J9PKXH6NL3h/OKfn3TQT1K9G8iWCkM=";
        })
      ];
    };
  };
}
