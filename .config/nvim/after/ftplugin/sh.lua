-- Filetype plugin for shell scripts
vim.cmd.iabbrev('<buffer>', '#!', '#!/bin/bash<Return>set -eu -o pipefail<Return>')
vim.opt_local.formatoptions:remove({'o', 'r'})
