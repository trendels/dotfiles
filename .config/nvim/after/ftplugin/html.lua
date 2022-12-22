-- Filetype plugin for HTML
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

vim.cmd.iabbrev('<buffer>', 'dth', '<!doctype html>')

-- Map Ctrl-/ to close tags with Omni Completion.
-- Getting the indentation right requires some fiddling around with the
-- closing bracket.
vim.keymap.set('i', '<C-/>', '</<C-X><C-O><Backspace> <Backspace>>', {buffer=true})
