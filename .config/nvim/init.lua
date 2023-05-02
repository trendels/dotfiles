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

-- Open new vertical splits to the right
vim.o.splitright = true

-- Scroll when one line away from the edge of the window
vim.o.scrolloff = 1

-- Allow navigating away from buffers with unsaved changes
vim.o.hidden = true

-- Switch between buffers with Ctrl-n/Ctrl-p
vim.keymap.set('n', '<C-n>', ':bnext<Return>')
vim.keymap.set('n', '<C-p>', ':bprev<Return>')

-- Switch between windows with Ctrl-h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Don't add trailing newline to files that don't already have one
vim.o.fixeol = false

-- Keep the old behaviour of 'Y' (yank line, now 'yy').
vim.keymap.set('n', 'Y', 'Y')
-- <Space> clears search result highlighting
vim.keymap.set('n', '<Space>', ':nohlsearch<Return>', {silent = true})

-- only complete to longest common prefix, don't open preview buffer
vim.opt.completeopt:append('longest')
vim.opt.completeopt:remove('preview')

-- On MacOS, Control-Space is mapped to "select previous input source" by
-- default. The shortcut needs to be disabled in System Preferences before it
-- can be mapped here.
-- These lines may be needed on some terminals that insert NUL for Ctrl-Space:
--vim.keymap.set('i', '<Nul>', '<C-Space>')
--vim.keymap.set('s', '<Nul>', '<C-Space>')

-- Trigger omni completion with Ctrl-Space
-- When the completion menu is open, Ctrl-Space selects the next entry
vim.keymap.set('i', '<C-Space>', function ()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-x><C-o>'
end, { expr = true, noremap = True })

-- When the completion menu is open, Tab selects the next entry
vim.keymap.set('i', '<Tab>', function ()
    -- Extra <C-]> is needed to un-break abbreviations (See :help abbreviations)
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-]><Tab>'
end, { expr = true })

-- When the completion menu is open, Space accepts the current entry regardless of state
vim.keymap.set('i', '<Space>', function ()
    -- Extra <C-]> is needed to un-break abbreviations (See :help abbreviations)
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<C-]><Space>'
end, { expr = true })

-- When the completion menu is open, Return accepts the current entry
vim.keymap.set('i', '<Return>', function ()
    -- Extra <C-]> is needed to un-break abbreviations (See :help abbreviations)
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<C-]><Return>'
end, { expr = true })

-- Apply overrides for the default color scheme
local augroup = vim.api.nvim_create_augroup('colorscheme_overrides', {clear = true})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'default',
    group = augroup,
    desc = 'Apply overrides',
    callback = function()
        vim.api.nvim_set_hl(0, 'LineNr', {ctermfg = 240})  -- Dark gray line numbers
        vim.api.nvim_set_hl(0, 'NonText', {ctermfg = 240}) -- Dark gray 'listchars'
        vim.api.nvim_set_hl(0, 'SpellBad', {cterm = {undercurl = true}, ctermfg = 'red'})
        vim.api.nvim_set_hl(0, 'SpellCap', {cterm = {undercurl = true}, ctermfg = 'blue'})
        vim.api.nvim_set_hl(0, 'SpellRare', {cterm = {undercurl = true}, ctermfg = 'magenta'})
        vim.api.nvim_set_hl(0, 'SpellLocal', {cterm = {undercurl = true}, ctermfg = 'cyan'})
        -- buffer opened in another window
        vim.api.nvim_set_hl(0, 'BufTabLineActive', {ctermbg = 0, ctermfg = 'darkcyan'})
        -- dark red color for diagnostics errors that is readable on popup window background
        vim.api.nvim_set_hl(0, 'DiagnosticError', {ctermfg = 124})
        vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {link = 'Ignore'})
    end
})

-- Set the color scheme
vim.cmd.colorscheme('default')

-- Restore previous cursor position when editing a file
-- See https://stackoverflow.com/a/72939989
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    desc = 'Restore previous cursor position',
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- Shortcuts
vim.g.mapleader = ','
vim.keymap.set('n', '<Leader>w', ':w<Return>')
vim.keymap.set('n', '<Leader>q', ':q<Return>')
vim.keymap.set('n', '<Leader>x', ':x<Return>')
vim.keymap.set('n', '<Leader>s', ':set invspell<Return>')
vim.keymap.set('n', '<Leader>p', ':set invpaste<Return>')
vim.keymap.set('n', '<Leader>m', ':!make<Return>')
vim.keymap.set('n', '<Leader>c', ':cclose | lclose<Return>', {silent = true})

-- ,dd inserts the current date as YYYY-MM-DD in insert mode
vim.keymap.set('i', ',dd', 'strftime("%Y-%m-%d")', {expr = true})

-- Decrease idle timeout (for "cursor hold" events, sign column updates)
vim.o.updatetime = 300  -- time in milliseconds

-- vim-buftabline: always show buffer list
vim.g.buftabline_show = 2

-- make directory listing (netrw) buffers better behaved (close when file is selected)
vim.g.netrw_fastbrowse = 0

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
    vim.keymap.set('n', '<space><space>', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
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
end

local lsp_flags = { debounce_text_changes = 150 }
local lspconfig = require('lspconfig')

lspconfig.pyright.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    -- Don't display diagnostic text for unused function arguments
    -- See https://github.com/microsoft/pyright/issues/1118#issuecomment-1481194616
    handlers = {
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                signs = { severity = { min = vim.diagnostic.severity.INFO } },
            }
        )
    },
})

lspconfig.rust_analyzer.setup({on_attach = on_attach, flags = lsp_flags})
