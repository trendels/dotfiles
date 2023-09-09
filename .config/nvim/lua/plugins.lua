-- Run :PackerInstall after adding plugins.
-- Run :PackerClean after removing plugins.
-- Run :helptags ALL to (re)generate help pages.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Manage packer itself
  use 'ap/vim-buftabline'
  --use 'airblade/vim-gitgutter'
  --use 'lewis6991/gitsigns.nvim'
  use 'neovim/nvim-lspconfig'
  use 'fatih/vim-go'
  use 'imsnif/kdl.vim'
  use 'romainl/vim-cool'
end)
