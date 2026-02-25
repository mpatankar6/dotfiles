vim.diagnostic.config({ virtual_text = true })
vim.g.mapleader = " "

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.signcolumn = "yes"

require("fzf-lua").setup()
require("gitsigns").setup({
  current_line_blame_opts = { delay = 0 }
})
require("lualine").setup({})
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

vim.lsp.enable({
  "clangd",
  "lua_ls",
  "marksman",
  "nixd",
  "ruff",
  "rust_analyzer",
  "ty",
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format Buffer" })
local fzf_lua = require("fzf-lua")
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
local gitsigns = require("gitsigns")
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Next Hunk" })
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Previous Hunk" })
vim.keymap.set("n", "<leader>rh", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>ph", gitsigns.preview_hunk, { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select In Hunk Text Object" })
local oil = require("oil")
vim.keymap.set("n", "<leader>o", oil.open, { desc = "Open Oil" })
