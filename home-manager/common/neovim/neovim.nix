{ pkgs, ... }:

let
  _ =
    assert
      !(builtins.hasAttr "everforest-nvim" pkgs.vimPlugins)
      || throw "everforest-nvim is now in nixpkgs. Remove the manual buildVimPlugin.";
    null;
  everforest-nvim = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "everforest-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "main";
        hash = "sha256-3ZCEozCPmMGYyLt6Oy4F1S6M8bfwNDzFnVjgAda7UCw=";
      };
    };
    type = "lua";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      everforest-nvim
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
  stylix.targets.neovim.enable = false;
}
