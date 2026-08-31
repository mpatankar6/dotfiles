{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      dropbar-nvim
      fzf-lua
      gitsigns-nvim
      lualine-nvim
      markdown-preview-nvim
      nord-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      oil-nvim
    ];

    extraPackages = with pkgs; [
      bash-language-server
      biome
      llvmPackages_22.clang-tools
      lua-language-server
      marksman
      nixd
      nixfmt
      ruff
      tinymist
      ty
      typescript-language-server
      zls
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
