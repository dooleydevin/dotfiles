{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

  # ── Nix PATH ──────────────────────────────────────────────────────
  # Source nix.sh in ~/.profile so nix-installed tools are on PATH
  # for all shell types (login, interactive, and non-interactive).
  home.sessionVariablesExtra = ''
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
  '';

  # ── Packages ────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    curl
    wget
    ripgrep
    fd
    jq
    htop
    zsh-powerlevel10k
    zsh-vi-mode
  ];

  # ── Git ─────────────────────────────────────────────────────────────
  programs.git = {
    enable = true;
    userName = "Devin Dooley";
    userEmail = "dooleydevin@github.com";
    extraConfig = {
      pull.rebase = false;
      core.editor = "vim";
    };
  };

  # ── Bash ────────────────────────────────────────────────────────────
  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ../bash/bashrc;
  };

  home.file.".bash_profile".text = ''
    if [ -e "$HOME/.profile" ]; then
      . "$HOME/.profile"
    fi
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
  '';

  # ── Zsh ─────────────────────────────────────────────────────────────
  programs.zsh = {
    enable = true;

    initExtraFirst = ''
      # Source nix profile so nix-installed tools are on PATH
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi

      # Enable Powerlevel10k instant prompt (must be at the top of .zshrc)
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      HYPHEN_INSENSITIVE="true"

      # Disable oh-my-zsh self-update; nix manages the version
      zstyle ':omz:update' mode disabled
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "zsh-vi-mode" ];
      custom = "$HOME/.oh-my-zsh-custom";
      theme = "powerlevel10k/powerlevel10k";
    };

    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      export EDITOR="vim"
      export VISUAL="vim"

      if [ "$(command -v go)" ]; then
        export PATH=$PATH:$(go env GOPATH)/bin
      fi

      if [ "$(command -v rbenv)" ]; then
        eval "$(rbenv init -)"
      fi
    '';
  };

  # ── Zsh plugins via oh-my-zsh custom directory ──────────────────────
  home.file.".oh-my-zsh-custom/themes/powerlevel10k".source =
    "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  home.file.".oh-my-zsh-custom/plugins/zsh-vi-mode".source =
    "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";

  # ── Powerlevel10k config ────────────────────────────────────────────
  home.file.".p10k.zsh".source = ../zsh/p10k.zsh;

  # ── Vim ─────────────────────────────────────────────────────────────
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-gitgutter
      papercolor-theme
      vim-airline
      vim-airline-themes
      ale
    ];
    extraConfig = builtins.readFile ../vim/vimrc;
  };
}
