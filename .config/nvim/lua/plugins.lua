-- Run :PackerInstall after adding plugins.
-- Run :PackerClean after removing plugins.
-- Run :helptags ALL to (re)generated help pages.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Manage packer itself
  use 'ap/vim-buftabline'
end)
