{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      fzf-lua
      gitsigns-nvim
      lualine-nvim
      markdown-preview-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      oil-nvim
    ];

    extraPackages = with pkgs; [
      bash-language-server
      biome
      clang-tools
      lua-language-server
      marksman
      nixd
      nixfmt
      typescript-language-server
      zls
    ];

    initLua = builtins.readFile ./init.lua;
  };
  catppuccin.nvim.settings = {
    transparent_background = true;
    show_end_of_buffer = true;
  };
}
