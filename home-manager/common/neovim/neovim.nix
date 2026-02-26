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
      clang-tools
      lua-language-server
      marksman
      nixd
      nixfmt
    ];

    initLua = builtins.readFile ./init.lua;
  };
  catppuccin.nvim.settings = {
    transparent_background = true;
    show_end_of_buffer = true;
  };
}
