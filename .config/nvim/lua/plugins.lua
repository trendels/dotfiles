-- Run :PackerInstall after adding plugins.
-- Run :PackerClean after removing plugins.
-- Run :helptags ALL to (re)generated help pages.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Manage packer itself
  use 'ap/vim-buftabline'
  --use 'airblade/vim-gitgutter' -- TODO needs some configuration to be useable (color scheme)
  use 'neovim/nvim-lspconfig'
  use 'fatih/vim-go'
end)
