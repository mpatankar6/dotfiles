-- Global settings and options
vim.diagnostic.config({ virtual_text = true })
vim.g.mapleader = " "

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

-- Plugins
vim.pack.add({
  "https://github.com/catppuccin/nvim.git",
  "https://github.com/ibhagwan/fzf-lua.git",
  "https://github.com/neovim/nvim-lspconfig.git",
  "https://github.com/nvim-lualine/lualine.nvim.git",
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  "https://github.com/stevearc/oil.nvim.git",
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  auto_integrations = true,
})
vim.cmd("colorscheme catppuccin")
require('fzf-lua').setup()
require('lualine').setup({})
---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = { enable = true },
  additional_vim_regex_highlighting = false
})
require('oil').setup()
require('blink.cmp').setup({
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },
  keymap = { preset = "enter" }
})

-- LSP configuration
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { library = vim.api.nvim_get_runtime_file("", true) }
    }
  }
})
vim.lsp.config("ty", {
  settings = {
    ty = {
      experimental = { rename = true, autoImport = true }
    }
  }
})
vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd", "ruff", "ty", "ts_ls", "biome" })

-- Autocmds
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and
        (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

-- Keymaps
vim.keymap.set("n", "<leader>rn", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative Line Numbers" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Current Buffer" })
vim.keymap.set("n", "<leader>W", ":wa<CR>", { desc = "Save All Buffers" })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to System Clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from System Clipboard' })
vim.keymap.set('x', '<leader>p', '"+P', { desc = 'Paste from System Clipboard' })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>O", ":Oil<CR>", { desc = "Open Oil" })

local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fr", fzf_lua.registers, { desc = "Find Registers" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fm", fzf_lua.marks, { desc = "Find Marks" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", fzf_lua.helptags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>s", fzf_lua.spell_suggest, { desc = "Spelling Suggestions" })
