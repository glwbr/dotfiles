{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.tools.tmux;
in
{
  options.aria.tools.tmux = {
    enable = mkBoolOpt false "Whether to enable tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      keyMode = "vi";
      historyLimit = 100000;
      newSession = true;
      shortcut = "a";
      terminal = "alacritty";
      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        vim-tmux-navigator
        resurrect
        continuum
      ];
      extraConfigBeforePlugins = ''
        # Configuration for resurrect plugin
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-capture-pane-contents 'on'
        set -g @resurrect-processes 'ssh btm yazi'
        set -g @resurrect-dir '~/.local/state/tmux/resurrect'

        # Configuration for continuum plugin
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '15'
        set -g status-right 'Continuum status: #{continuum_status}'
      '';
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
