"plugins
call plug#begin('~/.vim/plugged')
  Plug 'pangloss/vim-javascript'
  Plug 't1mxg0d/vim-lucario'
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
  Plug 'ternjs/tern_for_vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'airblade/vim-gitgutter'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'
call plug#end()

"editor
set tabstop=2
set shiftwidth=2
set expandtab
set nu
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray
set clipboard=unnamed
set updatetime=250
set exrc
set secure
syntax enable
set undolevels=1000
set relativenumber
set number

"airline
let g:airline#extensions#tabline#buffer_idx_mode = 1

"theme
"set termguicolors
colorscheme lucario
set background=dark

"gitgutter
set signcolumn=yes

"deoplete
let g:deoplete#enable_at_startup = 1

"md files
au BufRead,BufNewFile *.md setlocal textwidth=80 linebreak

