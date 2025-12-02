-- 1. Global settings
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Plugins
vim.pack.add({
				"https://github.com/catppuccin/nvim.git"
})

-- Plugin Configuration
require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				auto_integrations = true,
})
vim.cmd("colorscheme catppuccin")

-- 4. Keymaps and Autocmds

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>W", ":wa<CR>", { desc = "Save all buffers" })

local telescope = require("telescope.builtin")


vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "List Buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fgf", telescope.git_files, { desc = "Git Files" })
