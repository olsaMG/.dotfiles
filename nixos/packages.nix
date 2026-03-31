{ pkgs, pkgs-unstable, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add common libraries that might be needed
    stdenv.cc.cc.lib
    zlib
    openssl
    curl
    glibc
  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
      tmuxPlugins.yank
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # I use zsh btw
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "z" ];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };

  # for quickemu
  services.spice-vdagentd.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/eox/.dotfiles/nixos";
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [ pkgs.xorg.libxshmfence ];
      };
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
    # jdk21
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Applications
    discord
    ghostty
    krita
    google-chrome
    jetbrains.idea
    spotify-player
    quickemu
    spice-gtk
    teams-for-linux
    pkgs-unstable.rustdesk
    yazi
    LycheeSlicer

    # Devtools
    bun
    clang
    gemini-cli
    exercism
    dart-sass
    devenv
    vscode
    gh
    git
    gnumake
    go
    gcc
    templ
    lazygit
    leptosfmt
    libclang
    maven
    nodejs_24
    podman-compose
    postgresql
    python3
    tokei
    pkgs-unstable.biome
    quarkus
    rustup
    tailwindcss
    qmk

    # LSP
    buf
    tree-sitter
    lua-language-server
    lemminx
    gopls
    gofumpt
    jdt-language-server
    google-java-format
    nixd
    nixfmt-classic
    rust-analyzer
    tailwindcss-language-server
    typescript
    vscode-langservers-extracted

    # Rust
    openssl
    pkg-config

    # Utils
    bat
    btop
    curl
    grpcurl
    fzf
    httpie
    lsof
    usbutils
    dnsutils
    impala
    nmap
    jq
    gtk3
    flameshot
    fastfetch
    ripgrep
    openssl
    sshs
    starship
    syncthing
    stow
    tldr
    unzip
    vlc
    wget
  ];
}
