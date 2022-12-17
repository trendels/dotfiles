-- Filetype plugin for Python
vim.keymap.set('n', '<Leader>r', ':!python3 %<Return>')

vim.cmd.iabbrev('<buffer>', '#!', '#!/usr/bin/env python3')
vim.cmd.iabbrev('<buffer>', 'inm', '<Return>if __name__ == "__main__":<Return>main()<Esc>kkOdef main():')
vim.cmd.iabbrev('<buffer>', 'ffa', 'from __future__ import annotations')
