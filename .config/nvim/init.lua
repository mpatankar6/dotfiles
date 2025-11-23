-- ═══════════════════════════════════════════════════════════════════
-- 🎨 AMAZING NEOVIM CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════

-- ───────────────────────────────────────────────────────────────────
-- General Settings
-- ───────────────────────────────────────────────────────────────────
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Case-sensitive if uppercase present
vim.opt.hlsearch = true            -- Highlight search results
vim.opt.incsearch = true           -- Incremental search
vim.opt.wrap = false               -- Don't wrap lines
vim.opt.breakindent = true         -- Indent wrapped lines
vim.opt.tabstop = 4                -- Tab width
vim.opt.shiftwidth = 4             -- Indent width
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.autoindent = true          -- Auto indent
vim.opt.smartindent = true         -- Smart indent
vim.opt.scrolloff = 8              -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8          -- Keep 8 columns left/right of cursor
vim.opt.cursorline = true          -- Highlight current line
vim.opt.termguicolors = true       -- True color support
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.updatetime = 250           -- Faster completion
vim.opt.timeoutlen = 300           -- Faster key sequence completion
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard
vim.opt.splitbelow = true          -- Split below
vim.opt.splitright = true          -- Split right
vim.opt.undofile = true            -- Persistent undo
vim.opt.backup = false             -- No backup files
vim.opt.swapfile = false           -- No swap files
vim.opt.showmode = false           -- Don't show mode (shown in statusline)

-- ───────────────────────────────────────────────────────────────────
-- Key Mappings
-- ───────────────────────────────────────────────────────────────────
vim.g.mapleader = ' '              -- Set leader key to space
vim.g.maplocalleader = ' '

-- Clear search highlighting with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize windows with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Save file
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- Quit
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })

-- ───────────────────────────────────────────────────────────────────
-- Theme Configuration
-- ───────────────────────────────────────────────────────────────────
vim.cmd.colorscheme("unokai")

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- ───────────────────────────────────────────────────────────────────
-- Auto Commands
-- ───────────────────────────────────────────────────────────────────

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

-- ───────────────────────────────────────────────────────────────────
-- Status Line (simple built-in)
-- ───────────────────────────────────────────────────────────────────
vim.opt.laststatus = 2
vim.opt.statusline = '%#StatusLine# %f %m %= %y | %l:%c | %p%% '
