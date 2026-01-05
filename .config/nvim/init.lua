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

vim.pack.add({
  "https://github.com/catppuccin/nvim.git",
  "https://github.com/ibhagwan/fzf-lua.git",
  "https://github.com/neovim/nvim-lspconfig.git",
  "https://github.com/nvim-lualine/lualine.nvim.git",
  "https://github.com/stevearc/oil.nvim.git",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "master" },
  { src = "https://github.com/saghen/blink.cmp.git",                version = vim.version.range("*") },
})

require("catppuccin").setup({ transparent_background = true })
vim.cmd.colorscheme("catppuccin")
require("fzf-lua").setup()
require("lualine").setup({})
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
})
require("oil").setup()
require("blink.cmp").setup({
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },
  keymap = { preset = "enter" }
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { library = vim.api.nvim_get_runtime_file("", true) }
    }
  }
})
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }
    }
  }
})
vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd", "ruff", "ty", "denols" })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end
})

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format Buffer" })
local fzf_lua = require("fzf-lua")
fzf_lua.register_ui_select()
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fr", fzf_lua.resume, { desc = "Resume Find" })
vim.keymap.set("n", "<leader>fR", fzf_lua.registers, { desc = "Find Registers" })
vim.keymap.set("n", "<leader>fg", fzf_lua.grep_curbuf, { desc = "Grep Current Buffer" })
vim.keymap.set("n", "<leader>fG", fzf_lua.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fm", fzf_lua.marks, { desc = "Find Marks" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", fzf_lua.helptags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>fd", fzf_lua.diagnostics_document, { desc = "Find Diagnostics (Document)" })
vim.keymap.set("n", "<leader>fD", fzf_lua.diagnostics_workspace, { desc = "Find Diagnostics (Workspace)" })
vim.keymap.set("n", "<leader>s", fzf_lua.spell_suggest, { desc = "Spelling Suggestions" })
