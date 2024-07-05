{ config, pkgs, lib, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aka";
  home.homeDirectory = "/home/aka";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  #module
  imports = [ 
    ./vlc.nix
    ./module/mpd.nix
  ]; 
  home.packages = with pkgs; [
    nodejs_22
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.typescript-language-server
    #libgcc
    dmenu
    telegram-desktop
    google-chrome
    lxappearance
    rofi
    evince

    lua
    #llvmPackages.libcxxStdenv

    # c tools
    #gcc_multi
    #libstdcxx5
    #llvmPackages_18.libcxx
    #llvmPackages_18.libcxxClang
    #llvmPackages_18.clangUseLLVM
    clang-tools_18
    clang_18
    vscode-extensions.llvm-vs-code-extensions.vscode-clangd
    #rust lang
    cargo
    rustc
    rust-analyzer
    rustfmt
    #python
    python3

  ];

  home.file = { };

  # alacritty
  programs.alacritty = { enable = true; };

  # golang
  programs.go = {
    enable = true;
    goPath = ".go";
    goBin = ".go/bin";
  };


  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    vimAlias = true;

    extraLuaConfig = "	${builtins.readFile ./nvim/options.lua}\n";

    extraPackages = with pkgs; [
      #clipboard
      xclip
      wl-clipboard

      lua-language-server
      vscode-langservers-extracted
      nixfmt-classic

      #formatter nonels
      black
      python312Packages.black
      stylua
      pyright
    ];

    plugins = with pkgs.vimPlugins; [
      #treesitter
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-cpp
          p.tree-sitter-c
          p.tree-sitter-rust
          p.tree-sitter-go
          p.tree-sitter-html
          p.tree-sitter-javascript
          p.tree-sitter-css
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      #color-scheme
      {
        plugin = kanagawa-nvim;
        config = toLuaFile ./nvim/plugin/colorscheme.lua;
      }

      #lualine
      nvim-web-devicons
      {
        plugin = lualine-nvim;
        config = toLuaFile ./nvim/plugin/lualine.lua;
      }

      #auotpairs
      #nvim-cmp
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./nvim/plugin/autopairs.lua;
      }

      #cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      friendly-snippets
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      #lsp
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      #indentline
      {
        plugin = indent-blankline-nvim;
        config = toLua ''require("ibl").setup()'';
      }

      #comment
      {
        plugin = comment-nvim;
        config = toLua ''require("Comment").setup()'';
      }

      #none-ls
      plenary-nvim
      null-ls-nvim
      {
        plugin = none-ls-nvim;
        config = toLuaFile ./nvim/plugin/nonels.lua;
      }

      #colorizer
      {
        plugin = nvim-colorizer-lua;
        config = toLuaFile ./nvim/plugin/color.lua;
      }

      #nvim-tree
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./nvim/plugin/nvim-tree.lua;
      }

      #bufferline
      {
        plugin = bufferline-nvim;
        config = toLuaFile ./nvim/plugin/bufferline.lua;
      }
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true; # And some forgotten variations on this!
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aka/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
