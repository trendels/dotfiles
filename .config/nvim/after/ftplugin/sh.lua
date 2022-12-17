-- Filetype plugin for shell scripts
vim.cmd.iabbrev('<buffer>', '#!', '#!/bin/bash<Return>set -eu -o pipefail<Return>')
vim.opt.formatoptions:remove({'o', 'r'})
