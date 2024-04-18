{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    libnotify
    fontconfig

    # utils
    bottom
    dijo
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
    killall

    yt-dlp
    cfspeedtest
    onefetch
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
