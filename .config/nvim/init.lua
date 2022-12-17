-- NeoVim Lua Configuration
-- See https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/

-- Manage plugins with packer
require('plugins')

-- Show line numbers, share line and sign column ("gutter")
vim.o.number = true
vim.o.signcolumn = "number"

-- Tabs are 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Ignore case in search unless search term contains uppercase letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show trailing and non-breaking spaces, tabs, wrapped lines
vim.o.list = true
vim.o.listchars='trail:•,nbsp:•,tab:⇥ '
vim.o.showbreak='↳'

-- Allow navigating away from buffers with unsaved changes
vim.o.hidden = true
-- Switch between buffers with Ctrl-n/Ctrl-p
vim.keymap.set('n', '<C-n>', ':bnext<Return>')
vim.keymap.set('n', '<C-p>', ':bprev<Return>')

-- Keep the old behaviour of 'Y' (yank line, now 'yy').
vim.keymap.set('n', 'Y', 'Y')
-- <Space> clears search result highlighting
vim.keymap.set('n', '<Space>', ':nohlsearch<Return>', {silent = true})

-- Apply overrides for the default color scheme
local augroup = vim.api.nvim_create_augroup('colorscheme_overrides', {clear = true})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'default',
    group = augroup,
    desc = 'Apply overrides',
    callback = function()
        vim.api.nvim_set_hl(0, 'LineNr', {ctermfg = 8})     -- Grey line numbers
        vim.api.nvim_set_hl(0, 'NonText', {ctermfg = 8})    -- Grey 'listchars'
    end
})

-- Set the color scheme
vim.cmd.colorscheme('default')

-- Shortcuts
vim.g.mapleader = ','
vim.keymap.set('n', '<Leader>w', ':w<Return>')
vim.keymap.set('n', '<Leader>q', ':q<Return>')
vim.keymap.set('n', '<Leader>x', ':x<Return>')
vim.keymap.set('n', '<Leader>s', ':set invspell<Return>')
vim.keymap.set('n', '<Leader>p', ':set invpaste<Return>')
vim.keymap.set('n', '<Leader>m', ':!make<Return>')

-- Decrease idle timeout (for "cursor hold" events, sign column updates)
vim.o.updatetime = 300  -- time in milliseconds

-- vim-buftabline: always show buffer list
vim.g.buftabline_show = 2
