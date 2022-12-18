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

-- Don't add trailing newline to files that don't already have one
vim.o.fixeol = false

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
vim.keymap.set('n', '<Leader>c', ':cclose | lclose<Return>', {silent = true})

-- Decrease idle timeout (for "cursor hold" events, sign column updates)
vim.o.updatetime = 300  -- time in milliseconds

-- vim-buftabline: always show buffer list
vim.g.buftabline_show = 2

-- nvim-lspconfig
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', 'gS', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
    vim.keymap.set('n', '<space>ci', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<space>co', vim.lsp.buf.outgoing_calls, bufopts)
    vim.keymap.set('n', '<space>co', vim.lsp.buf.outgoing_calls, bufopts)
end
local lsp_flags = { debounce_text_changes = 150 }
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({on_attach = on_attach, flags = lsp_flags})
lspconfig.rust_analyzer.setup({on_attach = on_attach, flags = lsp_flags})
