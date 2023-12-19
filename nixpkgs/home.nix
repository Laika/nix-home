{ config, pkgs, lib, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.language.base = "en_US.UTF-8";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    # Utilities
    pkgs.ripgrep
    pkgs.fd
    pkgs.jq
    pkgs.docker
    pkgs.docker-compose
    pkgs.httpie
    pkgs.zoxide
    pkgs.vivid
    pkgs.eza

    # Language
    pkgs.lua

    pkgs.nodenv
    pkgs.nodejs_21

    pkgs.deno

    pkgs.rustup

    pkgs.python3
    (import ./python-packages.nix { inherit pkgs; })

    pkgs.rbenv

    pkgs.go

    # Archives
    pkgs.zip
    pkgs.xz
    pkgs.unzip

    # Network
    pkgs.nmap
    pkgs.httpie

    # CTF Tools
    pkgs.ghidra
    pkgs.strace
    pkgs.ltrace
    pkgs.rizin
    pkgs.rizinPlugins.rz-ghidra
    pkgs.gdb
    pkgs.pwndbg
    pkgs.gef
    pkgs.pwntools
    pkgs.pwninit
    pkgs.one_gadget
    pkgs.ropgadget

    pkgs.sage
    pkgs.hashcash

    pkgs.wireshark

    # pkgs.stegsolve

    # Formatter
    pkgs.nixfmt
    pkgs.sumneko-lua-language-server
    pkgs.ruff
    pkgs.gopls
    pkgs.gofumpt

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".pythonstartup".source = ../dotfiles/.pythonstartup;
    ".bash_alises".source = ../dotfiles/.bash_aliases;
    ".config/nvim" = {
      source = ../dotfiles/.config/nvim;
      recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_style = "space";
        indent_size = 4;
        insert_final_newline = true;
        max_line_length = 120;
        trim_trailing_whitespace = true;
      };
      "*.py" = { indent_size = 4; };
      "*.go" = { indent_size = 4; };
      "*.md" = { trim_trailing_whitespace = false; };
      "Makefile" = { indent_style = "tab"; };
    };
  };

  programs.git = {
    enable = true;
    userName = "laika";
    userEmail = "laika@albina.cc";
    extraConfig = { init = { defaultBranch = "main"; }; };
    aliases = {
      graph =
        "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      vim.opt.runtimepath:append('${../dotfiles/.config/nvim}')
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      scan_timeout = 10;
      format = ''
        $directory $username $hostname $git_branch $git_commit $docker_context $time
        $character'';

      character = {
        error_symbol = "[❯](bold red)";
        success_symbol = "[❯](bold green)";
      };

      directory = {
        truncation_length = 100;
        truncate_to_repo = false;
        truncation_symbol = "…/";
      };

      aws = {
        format = "[$symbol($profile )(($region) )]($style)";
        style = "bold blue";
        disabled = true;

        region_aliases = { ap-northeast-1 = "jp"; };
      };

      custom = {
        arch = {
          command = "uname -m";
          when = ''test $(uname -m) = "x86_64"'';
          style = "bold yellow";
          format = "[$output]($style)";
        };
      };

      docker_context = {
        format = "via [$symbol $context](blue bold)";
        detect_files = [
          "docker-compose.yml"
          "docker-compose.yaml"
          "Dockerfile"
          "compose.yml"
          "compose.yaml"
        ];
        disabled = true;
      };

      git_branch.format = "[$symbol$branch]($style) ";
      git_commit.format = "[($hash$tag)]($style) ";

      hostname = {
        ssh_only = true;
        ssh_symbol = "";
        format = "[@ $hostname]($style) ";
        style = "cyan";
      };

      time = {
        disabled = true;
        format = "[[$time]]($style) ";
        time_format = "%T";
        utc_time_offset = "+9";
        style = "blue";
      };

      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = true;
        show_always = true;
      };
    };

  };

  programs.ruff = {
    enable = true;
    settings = { line-length = 120; };

  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = builtins.readFile ../dotfiles/.bashrc;
    historyFileSize = 100000;
    historyIgnore = [ "history" "ls" "pwd" "cd" "top" "w" ];
    historySize = 100000;
    shellOptions = [
      "checkwinsize"
      "autocd"
      "cdspell"
      "dirspell"
      "globstar"
      "dotglob"
      "extglob"
      "nocaseglob"
    ];
  };

  programs.sagemath = {
    initScript = ''
      %colors linux
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.gh = { enable = true; };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    prefix = "M-q";
    mouse = true;
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
      tmuxPlugins.nord
      tmuxPlugins.cpu
      tmuxPlugins.open
      tmuxPlugins.fuzzback
    ];
    extraConfig = builtins.readFile ../dotfiles/.config/tmux/tmux.conf + ''
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    '';
  };

  programs.readline = {
    bindings = {
      "\\C-p" = "history-search-backward";
      "\\C-n" = "history-search-forward";
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
    };
    variables = {
      completion-ignore-case = true;
      colored-completion-prefix = true;
      colored-stats = true;
      bell-style = false;
      visible-stats = true;
    };
  };

  programs.ripgrep = {
    arguments = [
      "--max-columns=150"
      "--smart-case"
      "--max-columns-preview"
      "--colors=line:style:bold"
      "--glob='!git/*'"
    ];
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.home-manager.enable = true;

}

