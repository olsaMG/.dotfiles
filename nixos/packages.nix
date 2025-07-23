{ pkgs, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Applications
    discord
    ghostty
    krita
    google-chrome
    jetbrains.idea-ultimate
    spotify-player
    qemu
    quickemu
    teams-for-linux
    yazi
    LycheeSlicer

    # Devtools
    clang
    android-studio-full
    exercism
    dart-sass
    devenv
    gh
    git
    gnumake
    go
    templ
    jdk21
    lazygit
    leptosfmt
    libclang
    maven
    nodejs_24
    podman-compose
    postgresql
    python3
    prettierd
    quarkus
    rustup
    tailwindcss

    # LSP
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

    # Utils
    bat
    btop
    curl
    fzf
    httpie
    lsof
    usbutils
    dnsutils
    nmap
    jq
    fastfetch
    ripgrep
    openssl
    sshs
    starship
    syncthing
    stow
    tldr
    unzip
    wget
  ];
}
